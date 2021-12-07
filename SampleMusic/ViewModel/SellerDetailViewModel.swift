//
//  SellerDetailViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.10.21.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import Dip
import UIKit
import AVFoundation
import RealmSwift


class SellerDetailViewModel: SellerImp {
    
    
    var reloadView : (() -> Void)?
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var image: ((Data) -> Void)?
    var dismissAlert: ((Bool) -> Void)?
    var fieldData : ((String,String,String,String,String) -> Void)?
    var sampleData : String?
    let imageView = UIImageView()
    var imageArray = [String]()
    var sampleUrl = [String]()
    var totalSeconds : Int?
    let realm = try! Realm()
    var state : Results<State>?
    var duratation : String?
    var ownerUid : String?
    var imageUrl : String?
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    var samplesData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func userData() {
        if let user = Auth.auth().currentUser {
            let state = State()
            state.state = user.uid
            self.saveUid(state)
            self.db?.collection(Role.seller.rawValue.lowercased()).document(user.uid).getDocument(completion: { (document, error) in
                if let data = document?.data() {
                    let sellerData = DetailModel(data: data)
                    let imgRef = self.st?.reference(forURL: sellerData.imageUrl)
                    imgRef?.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            self.image?(data!)
                            self.dismissAlert?(true)
                        }
                    })
                    DispatchQueue.main.async {
                        self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender)
                    }
                }
            })
        }
    }
    
    func getDataFromUser(ownerUid: String) {
        self.db?.collection(Role.seller.rawValue.lowercased()).document(ownerUid).getDocument(completion: { (document, error) in
            if let data = document?.data() {
                let sellerData = DetailModel(data: data)
                let imgRef = self.st?.reference(forURL: sellerData.imageUrl)
                imgRef?.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.image?(data!)
                        self.dismissAlert?(true)
                    }
                })
                DispatchQueue.main.async {
                    self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender)
                }
            }
        })
    }
    
    func getDataSamplesFromUser(ownerUid: String) {
        let refrence = db?.collection(Role.sample.rawValue.lowercased())
        refrence?.whereField("ownerUid", isEqualTo: ownerUid)
            .order(by: "index")
            .addSnapshotListener(includeMetadataChanges: true, listener: { documentSnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var resData = [SampleModel]()
                    for document in documentSnapshot!.documents {
                        let sampleData = SampleModel(data: document.data())
                        resData.append(sampleData)
                    }
                    self.fetchData(res: resData)
                }
            })
    }
    
    func currentUserUid() -> String {
        return Auth.auth().currentUser!.uid
    }
    
    func getSamplesData() {
        if let user = Auth.auth().currentUser {
            let refrence = db?.collection(Role.sample.rawValue.lowercased())
            refrence?.whereField("ownerUid", isEqualTo: user.uid)
                .order(by: "index")
                .addSnapshotListener(includeMetadataChanges: true, listener: { documentSnapshot, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        var resData = [SampleModel]()
                        for document in documentSnapshot!.documents {
                            let sampleData = SampleModel(data: document.data())
                            resData.append(sampleData)
                        }
                        self.fetchData(res: resData)
                    }
                })
        }
    }
    
    func fetchData(res: [SampleModel]) {
        var resData = [DataCellModel]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        samplesData = resData
        
    }
    
    func createCellModel(cell: SampleModel) -> DataCellModel {
        let ownerUid = cell.ownerUid
        
        self.imageArray.append(cell.sampleImageUrl ?? "")
        for img in self.imageArray {
            self.imageUrl = img
        }
        
        self.sampleUrl.append(cell.sampleUrl ?? "")
        for smp in self.sampleUrl {
            self.sampleData = smp
        }
        
        let name = cell.sampleName
        let totalSeconds = cell.duration ?? 0
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        self.totalSeconds = totalSeconds
        self.duratation = String(format:"%02i:%02i",minutes, seconds)
        
        let sampleIndex = cell.index
        
        
        return DataCellModel(imageSample: self.imageUrl ?? "",
                             sampleName: name ?? "",
                             sampleData: self.sampleData ?? "",
                             totalSeconds: self.totalSeconds ?? 0,
                             sampleDuratation: self.duratation ?? "",
                             ownerUid: ownerUid ?? "",
                             index: sampleIndex ?? 0
        )
    }
    
    func getCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesData[indexPath.row]
    }
    
    func deleteSample(by name: String) {
        self.db?.collection(Role.sample.rawValue.lowercased()).whereField("sampleName", isEqualTo: name)
            .getDocuments(completion: { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for document in querySnapshot!.documents {
                        self.deleteFromFirestore(document.documentID,name: name)
                    }
                }
            })
    }
    
    private func deleteFromFirestore(_ documentId: String,name: String) {
        self.db?.collection(Role.sample.rawValue.lowercased()).document(documentId).delete(completion: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.deleteImageStorage(by: name)
            }
        })
    }
    
    private func deleteImageStorage(by name: String) {
        let imgRef = st?.reference().child("imageSamples/\(name).jpg")
        imgRef?.delete(completion: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.deleteSampleData(by: name)
            }
        })
    }
    
    private func deleteSampleData(by name: String) {
        let sampleRef = st?.reference().child("musicSamples/\(name).m4a")
        sampleRef?.delete(completion: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Delete success")
            }
        })
    }
    
    func getSampleIndex(start index: Int, destination destIndex: Int) {
        self.db?.collection(Role.sample.rawValue.lowercased())
            .whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid as Any)
            .whereField("index", isEqualTo: index)
            .getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var first = index
                    var second = destIndex
                    for document in querySnapshot!.documents {
                        first = second
                        if first == second {
                            self.changeSampleIndex(destinationIndex: first, documentId: document.documentID)
                        } else {
                            self.changeSampleIndex(destinationIndex: second, documentId: document.documentID)
                        }
                        
                    }
                }
            }
    }
    
    private func changeSampleIndex(destinationIndex: Int,documentId: String) {
        self.db?.collection(Role.sample.rawValue.lowercased()).document(documentId)
            .updateData([
                "index": destinationIndex as Any
            ])
    }

    
    func saveUid(_ state: State) {
        do {
            try realm.write {
                realm.add(state)
            }
        } catch {
            print("Error saving state \(error)")
        }
    }
    
    
}
