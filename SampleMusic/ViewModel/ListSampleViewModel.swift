//
//  ListSampleViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import Dip
import UIKit
import SDWebImage
import AVFoundation
import RealmSwift

class ListSampleViewModel: ListSamplesImp {    
    
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var dismissAlert: ((Bool) -> Void)?
    var sampleData : String?
    var hide : ((Bool) -> Void)?
    var sampleUrl = [String]()
    var totalSeconds : Int?
    let realm = try! Realm()
    var state : Results<State>?
    var duratation : String?
    var chatRoom : String?
    var curUser : String?
    var image : UIImageView?
    var imgArr = [String]()
    var imageUrl : String?

    
    var samplesData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    var searchData = [DataCellModel]()
    init (db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    func signUser() {
        if let user = Auth.auth().currentUser {
            let state = State()
            state.state = user.uid
            self.curUser = user.uid
            self.saveUid(state)
        }
    }
    
    func hideUserDetail() {
        if let user = Auth.auth().currentUser {
            db?.collection(Role.seller.rawValue.lowercased()).document(user.uid).addSnapshotListener({ [weak self] doc, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    if doc?.data() != nil {
                        self?.hide?(true)
                    }
                }
            })
        }
    }
    
    func createChatRoom(ownerUid: String, recieverUid: String) {
        let ref = db?.collection(Role.chatRoom.rawValue).document()
        let id = ref?.documentID
        ref?.setData([
            "chatRoom": id as Any,
            "ownerUid": ownerUid as Any,
            "recieverUid": recieverUid as Any
        ])
        self.chatRoom = id
        
    }
//    MARK: - TableViewData
        func getSamplesData() {
         db?.collection(Role.sample.rawValue.lowercased())
                .addSnapshotListener(includeMetadataChanges: true, listener: { querySnapshot, error in
                    guard let snapshot = querySnapshot else {
                        print("Error retreiving snapshot: \(error!)")
                        return
                    }
                    let queryData = snapshot.documents.map { (document) -> SampleModel in
                        let sampleData = SampleModel(data: document.data())
                        return sampleData
                    }
                    self.fetchData(res: queryData)
                    self.reloadTableView?()
                })
            self.dismissAlert?(true)
        }
    
    
    func fetchData(res: [SampleModel]) {
        var resData = [DataCellModel]()
        for r in res {
            resData.append(createCellModel(cell: r))
        }
        samplesData = resData
        searchData = samplesData
        
    }
    
    func createCellModel(cell: SampleModel) -> DataCellModel {
        let name = cell.sampleName
        let ownerUid = cell.ownerUid
        
        self.imgArr.append(cell.sampleImageUrl ?? "")
        for img in self.imgArr {
            self.imageUrl = img
        }

        self.sampleUrl.append(cell.sampleUrl ?? "")
        for smp in self.sampleUrl {
            self.sampleData = smp
        }
        
        let totalSeconds =  cell.duration ?? 0
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
    
    //MARK: - Filter
    func filterByName() {
        let sortedByName = samplesData.sorted { $0.sampleName < $1.sampleName }
        samplesData = sortedByName
    }
    
    func filterByTrackLength() {
        let sortedBySampleLength = samplesData.sorted { $0.totalSeconds < $1.totalSeconds }
        samplesData = sortedBySampleLength
    }
    
    //MARK: - Search
    func searchResults(text: String) {
        let search = searchData.filter { $0.sampleName.contains(text) }
        samplesData = search
    }
    
    func getSearchData() {
        samplesData = searchData
    }
    //MARK: - LogOut
    func logout() {
        do {
            try Auth.auth().signOut()
            try! realm.write({
                realm.deleteAll()
            })
            self.samplesData = []
        } catch let signOutError as NSError {
            print(signOutError.localizedDescription)
        }
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
