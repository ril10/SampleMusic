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
import RealmSwift


class ChatDetailViewModel: ChatDetailimp {
    
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var ownerUid : String?
    var chatRoom : String?
    var recieverUid : String?
    var imageUrl : Any?
    var firstName : String?
    var fcmToken : String?
    let realm = try! Realm()
    
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
        self.db?.collection(Collection.message.getCollection()).whereField("chatRoom", isEqualTo: self.chatRoom!)
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
    
    
    func getFCMtoken() {
        let state = realm.objects(State.self).first
        if state?.role == Collection.user.getCollection() {
            db?.collection(Collection.seller.getCollection()).document((self.recieverUid)!)
                .getDocument { (document, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        if document?.exists == true {
                            let token = NotificationModel(data: document!.data()!)
                            self.fcmToken = token.fcmToken
                        } else {
                            print("is empty")
                        }
                    }
                }
        } else {
            db?.collection(Collection.user.getCollection()).document((self.ownerUid)!)
                .getDocument { (document, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        if document?.exists == true {
                            let token = NotificationModel(data: document!.data()!)
                            self.fcmToken = token.fcmToken
                        } else {
                            print("is empty")
                        }
                    }
                }
        }
    }
    
    func getNameInNotification() {
        let state = realm.objects(State.self).first
        if state?.role == Collection.user.getCollection() {
            db?.collection(Collection.user.getCollection()).document(self.ownerUid!)
                    .getDocument { (document, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            if document?.exists == true {
                                let token = NotificationDataModel(data: document!.data()!)
                                self.firstName = token.firstName
                            } else {
                                print("is empty")
                            }
                        }
                    }
        } else {
            db?.collection(Collection.seller.getCollection()).document(self.recieverUid!)
                    .getDocument { (document, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            if document?.exists == true {
                                let token = NotificationDataModel(data: document!.data()!)
                                self.firstName = token.firstName
                            } else {
                                print("is empty")
                            }
                        }
                    }
        }
    }
    
    func sendMessage(text: String) {
        let sender = PushNotificationSender()
        if let user = Auth.auth().currentUser {
            if text != "" {
                self.db?.collection(Collection.message.getCollection()).document().setData([
                    "message":text as Any,
                    "sendDate": Date().timeIntervalSince1970,
                    "ownerUid": user.uid as Any,
                    "recieverUid": recieverUid as Any,
                    "chatRoom": self.chatRoom as Any
                ])
                self.db?.collection(Collection.chatRoom.getCollection()).document(self.chatRoom!).updateData([
                    "lastMessage":text as Any
                ])
                sender.sendPushNotification(to: fcmToken ?? "", title: firstName ?? "", body: text, recieverUid: recieverUid!, ownerUid: user.uid, roomUid: self.chatRoom!)
                self.reloadTableView?()
            }
        }
    }
}
