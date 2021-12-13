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
    var firstName : String?
    
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
    
    func getUserName(with uid: String) {
        db?.collection(Role.seller.rawValue.lowercased()).whereField("uid", isEqualTo: uid)
            .getDocuments(completion: { documentSnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    let name = documentSnapshot!.documents.map { $0["firstName"]! }
                    self.firstName = name as? String
                }
                for document in documentSnapshot!.documents {
                    if document.documentID.isEmpty {
                        self.db?.collection(Role.user.rawValue.lowercased()).whereField("uid", isEqualTo: uid)
                            .getDocuments(completion: { (document, error) in
                                if let error = error {
                                    print(error.localizedDescription)
                                } else {
                                    let name = document!.documents.map { $0["firstName"]! }
                                    self.firstName = name as? String
                                }
                            })
                    }
                }
            })
    }
    
    func sendMessage(text: String) {
        let sender = PushNotificationSender()
        if let user = Auth.auth().currentUser {
            getUserName(with: user.uid)
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
                sender.sendPushNotification(to: "caBJ7D-hIEprmQZsRQ8ub0:APA91bFRksmnnyfNyV5jmrsci9cjNoqNmoI99dfLUBgneRRxUBtn_IZ8hPxAm6tTAF5DgCSgZYViG5TleV5H50ju4GbDeobpso67egnHuJ_4GcgPB7Y_8D4KDRuS4YKRItnIvg9sLWJw", title: "Some guy", body: text)
                self.reloadTableView?()
            }
        }
    }
}
