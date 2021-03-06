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
    var imageUrl : Any?
    
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
        self.db.collection(Collection.chatRoom.getCollection()).whereField("recieverUid", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener(includeMetadataChanges: true) { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var resData = [ChatListModel]()
                    for document in querySnapshot!.documents {
                        let chatCell = ChatListModel(data: document.data())
                        resData.append(chatCell)
                    }
                    self.fetchData(res: resData)
                }
            }
    }
    
    func loadMessageIfUser() {
        self.db.collection(Collection.chatRoom.getCollection()).whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener(includeMetadataChanges: true) { querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var resData = [ChatListModel]()
                    for document in querySnapshot!.documents {
                        let chatCell = ChatListModel(data: document.data())
                        resData.append(chatCell)
                    }
                    self.fetchData(res: resData)
                }
            }
    }
    
    func ifUserSign() {
        if let user = Auth.auth().currentUser {
            self.db.collection(Collection.user.getCollection()).document(user.uid).addSnapshotListener { [weak self] doc, error in
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
            self.db.collection(Collection.seller.getCollection()).document(user.uid).addSnapshotListener { [weak self] doc, error in
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
        let senderUid = cell.senderUid
        let recieverUid = cell.recieverUid
        let chatRoom = cell.chatRoom
        let message = cell.lastMessage
        
        return CellChatModel(chatRoom: chatRoom!,
                             ownerUid: senderUid ?? "",
                             recieverUid: recieverUid ?? "",
                             message: message ?? "")
    }
    
    
    func getCellModel(at indexPath: IndexPath) -> CellChatModel {
        return chatList[indexPath.row]
    }
    
}
