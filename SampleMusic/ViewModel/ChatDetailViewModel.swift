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
    
    init(db: Firestore) {
        self.db = db
    }
    
    var messageData = [Message]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func loadMessages() {
        self.db?.collection(Role.message.rawValue).addSnapshotListener({ querySnapshot, error in
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
        messageData = resData
    }
    
    func createCellModel(cell: MessageDataModel) -> Message {
        let cellMessage = cell.message
        let cellUid = cell.senderUid
        let cellData = cell.data
        let tasks = localRealm.objects(ChatUser.self).first
        let tasksLeftImage = localRealm.objects(ChatUser.self).last
        let leftImage = UIImage(data: (tasksLeftImage?.recieverImage)!)
        let rightImage = UIImage(data: (tasks?.senderImage)!)
        return Message(senderUid: cellUid ?? "", body: cellMessage ?? "", date: cellData ?? 0.0, rightImage: rightImage!, leftImage: leftImage!)
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
                "recieverUid": tasks.first?.recieverUid
            ])
        }
    }
    
    func checkUser() {
        if let user = Auth.auth().currentUser {
            let tasks = localRealm.objects(ChatUser.self).first
            if tasks!.ownerUid == user.uid {
                self.hidden?(true)
            }
        }
    }
    
}
