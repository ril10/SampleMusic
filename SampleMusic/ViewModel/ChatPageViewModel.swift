//
//  ChatPageViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorageUI

class ChatPageViewModel: ChatPageImp {
    
    var reloadTableView : (() -> Void)?
    var db : Firestore
    var recieverUid : String?
    var userSign : ((Bool) -> Void)?
    var sellerSign : ((Bool) -> Void)?
    
    init(db: Firestore) {
        self.db = db
    }
    
    var chatList = [CellChatModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func loadMessages() {
        self.db.collection(Role.chatRoom.rawValue).whereField("recieverUid", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments { querySnapshot, error in
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
        self.db.collection(Role.chatRoom.rawValue).whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid)
            .getDocuments { querySnapshot, error in
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
        let senderUid = cell.senderUid
        let recieverUid = cell.recieverUid
        let chatRoom = cell.chatRoom
        
        return CellChatModel(image: UIImage(systemName: Icons.photo.rawValue)!, chatRoom: chatRoom!, senderUid: senderUid ?? "", recieverUid: recieverUid ?? "")
    }
    
    func getCellModel(at indexPath: IndexPath) -> CellChatModel {
        return chatList[indexPath.row]
    }
    
}
