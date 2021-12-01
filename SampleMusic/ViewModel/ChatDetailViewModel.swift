//
//  ChatDetailViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Dip
import RealmSwift


class ChatDetailViewModel: ChatDetailimp {

    var reloadTableView : (() -> Void)?
    var db : Firestore?
    let localRealm = try! Realm()
    var hidden : ((Bool) -> Void)?
    var senderUid : String?
    var recUid : String?
    var ownerUid : String?
    var chatRoom : String?
    var recieverUid : String?
    
    init(db: Firestore) {
        self.db = db
    }
    
    var messageData = [Message]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func loadMessages() {
        self.db?.collection(Role.message.rawValue).whereField("chatRoom", isEqualTo: self.chatRoom!)
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
    
    
    func fetchData(res: [MessageDataModel]) {
        var resData = [Message]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        messageData = resData.sorted { $0.date < $1.date }
    }
    
    func createCellModel(cell: MessageDataModel) -> Message {
        let cellMessage = cell.message
        let cellUid = cell.ownerUid
        self.senderUid = cellUid
        let cellData = cell.sendDate
        let recieverUid = cell.recieverUid
        self.recUid = recieverUid
        let tasks = localRealm.objects(ChatUser.self).first
        let tasksLeftImage = localRealm.objects(ChatUser.self).last
        let leftImage = UIImage(systemName: Icons.photo.rawValue)//UIImage(data: (tasksLeftImage?.recieverImage)!)
        let rightImage = UIImage(systemName: Icons.photo.rawValue)//UIImage(data: (tasks?.senderImage)!)
        return Message(senderUid: cellUid ?? "", body: cellMessage ?? "", date: cellData ?? 0.0, rightImage: rightImage!, leftImage: leftImage!,recieverUid: self.ownerUid!)
    }
    
    func getCellModel(at indexPath: IndexPath) -> Message {
        return messageData[indexPath.row]
    }
    
    func sendMessage(text: String) {
        let tasks = localRealm.objects(ChatUser.self).where { $0.recieverUid != nil }
        if let user = Auth.auth().currentUser {
            self.db?.collection(Role.message.rawValue).document().setData([
                "message":text as Any,
                "sendDate": Date().timeIntervalSince1970,
                "ownerUid": user.uid as Any,
                "recieverUid": recieverUid as Any,//tasks.first?.recieverUid as Any
                "chatRoom": self.chatRoom as Any
            ])
        }
    }
    
    func checkUser() {
        if let user = Auth.auth().currentUser {
//            let tasks = localRealm.objects(ChatUser.self).first
//            if tasks!.ownerUid == user.uid {
//                self.hidden?(true)
//            }
            if user.uid == ownerUid! {
                self.hidden?(true)
            }
        }
    }
    
}
