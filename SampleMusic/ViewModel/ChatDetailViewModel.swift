//
//  ChatDetailViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Dip


class ChatDetailViewModel: ChatDetailimp {
    
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var ownerUid : String?
    var chatRoom : String?
    var recieverUid : String?
    var imageUrl : Any?
    
    
    init(db: Firestore, st: Storage) {
        self.db = db
        self.st = st
    }
    
    var messageData = [Message]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func loadMessages() {
        self.db?.collection(Role.message.rawValue).whereField("chatRoom", isEqualTo: self.chatRoom!)
            .order(by: "sendDate")
            .addSnapshotListener({ querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var resData = [MessageDataModel]()
                    for document in querySnapshot!.documents {
                        let messageData = MessageDataModel(data: document.data())
                        resData.append(messageData)
                    }
                    self.fetchData(res: resData)
                }
            })
    }
    
    func checkCurrentUser() -> String {
        guard let user = Auth.auth().currentUser else { return "" }
        return user.uid
    }
    
    
    func fetchData(res: [MessageDataModel]) {
        var resData = [Message]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        messageData = resData
    }
    
    func createCellModel(cell: MessageDataModel) -> Message {
        let cellMessage = cell.message
        let cellUid = cell.ownerUid
        let cellData = cell.sendDate
        
        return Message(senderUid: cellUid ?? "",
                       body: cellMessage ?? "",
                       date: cellData ?? 0.0,
                       recieverUid: self.ownerUid!)
    }
    
    func getCellModel(at indexPath: IndexPath) -> Message {
        return messageData[indexPath.row]
    }
    
    func sendMessage(text: String) {
        if let user = Auth.auth().currentUser {
            if text != "" {
                self.db?.collection(Role.message.rawValue).document().setData([
                    "message":text as Any,
                    "sendDate": Date().timeIntervalSince1970,
                    "ownerUid": user.uid as Any,
                    "recieverUid": recieverUid as Any,
                    "chatRoom": self.chatRoom as Any
                ])
                self.db?.collection(Role.chatRoom.rawValue).document(self.chatRoom!).updateData([
                    "lastMessage":text as Any
                ])
                self.reloadTableView?()
            }
        }
    }
}
