//
//  ChatPageViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ChatPageViewModel: ChatPageImp {
    
    var reloadTableView : (() -> Void)?
    var db : Firestore
    var st : Storage
    var recieverUid : String?
    var userSign : ((Bool) -> Void)?
    var sellerSign : ((Bool) -> Void)?
    var imageAvatar : String?
    var leftImage : String?
    var rightImage : String?
    var message : Any?
    var imageUrl : Any?
    var uidImg : String?
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    var chatList = [CellChatModel]() {
        didSet {
            reloadTableView?()
        }
    }

    
    func loadMessages() {
        self.db.collection(Role.chatRoom.rawValue).whereField("recieverUid", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener(includeMetadataChanges: true) { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var resData = [ChatListModel]()
                    for document in querySnapshot!.documents {
                        let chatCell = ChatListModel(data: document.data())
                        resData.append(chatCell)
                        self.getLastMessage(by: "recieverUid")
                        self.getImage(type: Role.user.rawValue.lowercased(),by: resData)
                    }
                    self.fetchData(res: resData)
                }
            }
    }
    
    func loadMessageIfUser() {
        self.db.collection(Role.chatRoom.rawValue).whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener(includeMetadataChanges: true) { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var resData = [ChatListModel]()
                    for document in querySnapshot!.documents {
                        let chatCell = ChatListModel(data: document.data())
                        resData.append(chatCell)
                        self.getLastMessage(by: "ownerUid")
                        self.getImage(type: Role.user.rawValue.lowercased(),by: resData)
                    }
                    self.fetchData(res: resData)
                }
            }
    }
    
    func ifUserSign() {
        if let user = Auth.auth().currentUser {
            self.db.collection(Role.user.rawValue.lowercased()).document(user.uid).addSnapshotListener { [weak self] doc, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    if doc?.data() != nil {
                        self?.userSign?(true)
                    }
                }
            }
        }
    }
    
    func ifSellerSign() {
        if let user = Auth.auth().currentUser {
            self.db.collection(Role.seller.rawValue.lowercased()).document(user.uid).addSnapshotListener { [weak self] doc, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        if doc?.data() != nil {
                            self?.sellerSign?(true)
                        }
                    }
                }
            }
    }
    
    func fetchData(res: [ChatListModel]) {
        var resData = [CellChatModel]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        chatList = resData
    }
    
    func createCellModel(cell: ChatListModel) -> CellChatModel {
        let senderUid = cell.ownerUid
        let recieverUid = cell.recieverUid
        let chatRoom = cell.chatRoom
        
        return CellChatModel(image: self.imageUrl as? String ?? "", chatRoom: chatRoom!, senderUid: senderUid ?? "", recieverUid: recieverUid ?? "", message: self.message as? String ?? "")
    }
    
   private func getLastMessage(by uid: String) {
        db.collection(Role.message.rawValue).whereField(uid, isEqualTo: Auth.auth().currentUser?.uid)
            .order(by: "sendDate")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    return
                }
                let dataMessage = documents.map { $0["message"]! }
                for data in dataMessage {
                    self.message = data
                }
                
            }
    }
    
    private func getImage(type user: String,by uid: [ChatListModel]) {
        for img in uid {
            db.collection(user).whereField("uid", isEqualTo: img.ownerUid)
                .addSnapshotListener { (querySnapshot, error) in
                    guard let documents = querySnapshot?.documents else {
                        return
                    }
                    let dataImage = documents.map { $0["imageUrl"]! }
                    for data in dataImage {
                        self.imageUrl = data
                    }
                }
        }

    }
    
    func getCellModel(at indexPath: IndexPath) -> CellChatModel {
        return chatList[indexPath.row]
    }
    
}
