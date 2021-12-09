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
    var senderUid : String?
    var ownerUid : String?
    var chatRoom : String?
    var recieverUid : String?
    var leftImage : String?
    var rightImage : String?
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
            self.getImage(type: Role.seller.rawValue.lowercased(), by: (r.recieverUid)!)
            self.getImage(type: Role.user.rawValue.lowercased(), by: (r.ownerUid)!)
        }
        messageData = resData
    }
    
    func createCellModel(cell: MessageDataModel) -> Message {
        let cellMessage = cell.message
        let cellUid = cell.ownerUid
        self.senderUid = cellUid
        let cellData = cell.sendDate
        
        return Message(senderUid: cellUid ?? "",
                       body: cellMessage ?? "",
                       date: cellData ?? 0.0,
                       rightImage: self.imageUrl as? String ?? "",
                       leftImage: self.imageUrl as? String ?? "",
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
                self.reloadTableView?()
            }
        }
    }
    
    private func getImage(type user: String,by uid: String) {
        db?.collection(user).whereField("uid", isEqualTo: uid)
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
