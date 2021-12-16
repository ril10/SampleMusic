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
    var ownerUid: String?
    var reloadView : (() -> Void)?
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var dismissAlert: ((Bool) -> Void)?
    var fieldData : ((String,String,String,String,String,String) -> Void)?
    var sampleData : String?
    var imageArray = [String]()
    var sampleUrl = [String]()
    var totalSeconds : Int?
    let realm = try! Realm()
    var duratation : String?
    var imageUrl : String?
    var chatRoom : String?
    var goToChat : ((String) -> Void)?    
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    var samplesFreeData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var samplesPaidData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    //MARK: - Get user data
    func userData() {
        if let user = Auth.auth().currentUser {
            let dataState = realm.objects(State.self)
            if !dataState.isEmpty {
                print("Nothing to add")
            } else {
                let state = State()
                state.state = user.uid
                state.role = Collection.seller.getCollection()
                self.saveUid(state)
                let pushManager = PushNotificationManager(userUid: user.uid, role: Collection.seller.getCollection())
                pushManager.registerForPushNotifications()
            }
            self.db?.collection(Collection.seller.getCollection()).document(user.uid).addSnapshotListener( { (document, error) in
                if let data = document?.data() {
                    let sellerData = DetailModel(data: data)
                    DispatchQueue.main.async {
                        self.dismissAlert?(true)
                        self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender,sellerData.imageUrl)
                    }
                }
            })
        }
    }
    //MARK: - Get Samples Data From User Page
    func getDataFromUser(ownerUid: String) {
        self.db?.collection(Collection.seller.getCollection()).document(ownerUid).addSnapshotListener( { (document, error) in
            if let data = document?.data() {
                let sellerData = DetailModel(data: data)
                DispatchQueue.main.async {
                    self.dismissAlert?(true)
                    self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender,sellerData.imageUrl)
                }
            }
        })
    }
    
    func getDataSamplesFromUser(ownerUid: String) {
        let refrence = db?.collection(Collection.sample.getCollection())
        refrence?.whereField("ownerUid", isEqualTo: ownerUid)
            .whereField("type", isEqualTo: "free")
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
    func getPaidSamplesFromUserData(ownerUid: String) {
        let refrence = db?.collection(Collection.sample.getCollection())
        refrence?.whereField("ownerUid", isEqualTo: ownerUid)
            .whereField("type", isEqualTo: "paid")
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
                    self.fetchPaidData(res: resData)
                }
            })
    }
    //MARK: - Get Samples Data From Seller Page
    func getSamplesData() {
        if let user = Auth.auth().currentUser {
            let refrence = db?.collection(Collection.sample.getCollection())
            refrence?.whereField("ownerUid", isEqualTo: user.uid)
                .whereField("type", isEqualTo: "free")
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
    
    func getPaidSamplesData() {
        if let user = Auth.auth().currentUser {
            let refrence = db?.collection(Collection.sample.getCollection())
            refrence?.whereField("ownerUid", isEqualTo: user.uid)
                .whereField("type", isEqualTo: "paid")
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
                        self.fetchPaidData(res: resData)
                    }
                })
        }
    }
    //MARK: - Create Cell & Fetch Data
    func fetchData(res: [SampleModel]) {
        var resData = [DataCellModel]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        samplesFreeData = resData
    }
    
    func fetchPaidData(res: [SampleModel]) {
        var resData = [DataCellModel]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        samplesPaidData = resData
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
        
        let sampleCost = cell.cost
        
        
        return DataCellModel(imageSample: self.imageUrl ?? "",
                             sampleName: name ?? "",
                             sampleData: self.sampleData ?? "",
                             totalSeconds: self.totalSeconds ?? 0,
                             sampleDuratation: self.duratation ?? "",
                             ownerUid: ownerUid ?? "",
                             index: sampleIndex ?? 0,
                             cost: sampleCost ?? 0
        )
    }
    
    func getCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesFreeData[indexPath.row]
    }
    
    func getPaidCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesPaidData[indexPath.row]
    }
    //MARK: - Current user uid
    func currentUserUid() -> String {
        if let user = Auth.auth().currentUser {
            return user.uid
        }
        return ""
    }
    //MARK: - Chat Methods
    func checkChatRoom(ownerUid: String, recieverUid: String, completion: @escaping (Bool) -> Void? ) {
        db?.collection(Collection.chatRoom.getCollection()).whereField("ownerUid", isEqualTo: ownerUid)
            .whereField("recieverUid", isEqualTo: recieverUid)
            .getDocuments { (documents, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if documents!.isEmpty {
                        completion(true)
                        self.goToChat?(self.chatRoom ?? "")
                    } else {
                        documents?.documents.forEach({ document in
                            completion(false)
                            self.goToChat?(document.documentID)
                        })
                    }
                }
            }
    }
    
    func createChatRoom(ownerUid: String, recieverUid: String) {
                let ref = self.db?.collection(Collection.chatRoom.getCollection()).document()
                let id = ref?.documentID
                ref?.setData([
                    "chatRoom": id as Any,
                    "ownerUid": ownerUid as Any,
                    "recieverUid": recieverUid as Any
                ])
                self.chatRoom = id
            }
    //MARK: - Delete Sample
    func deleteSample(by name: String) {
        self.db?.collection(Collection.sample.getCollection()).whereField("sampleName", isEqualTo: name)
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
        self.db?.collection(Collection.sample.getCollection()).document(documentId).delete(completion: { error in
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
    //MARK: - Get Sample Index & Change Index
    func getSampleIndex(start index: Int, destination destIndex: Int) {
        self.db?.collection(Collection.sample.getCollection())
            .whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid as Any)
            .whereField("index", isEqualTo: index)
            .getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var first = index
                    let second = destIndex
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
        self.db?.collection(Collection.sample.getCollection()).document(documentId)
            .updateData([
                "index": destinationIndex as Any
            ])
    }

    //MARK: - Save to realm
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
