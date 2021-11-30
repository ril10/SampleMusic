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
    
    init(db: Firestore) {
        self.db = db
    }
    
    var chatList = [CellChatModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    func loadMessages() {
        if let user = Auth.auth().currentUser {
            self.db.collection(Role.message.rawValue).whereField("recieverUid", isEqualTo: user.uid)
                .addSnapshotListener({ querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var resData = [ChatListModel]()
                    for document in querySnapshot!.documents {
                        let messageData = ChatListModel(data: document.data())
                        resData.append(messageData)
                    }
                    self.fetchData(res: resData)
                    
                }
            })
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
        let message = cell.message
        
        return CellChatModel(image: UIImage(systemName: Icons.photo.rawValue)!, message: message!, senderUid: senderUid ?? "", recieverUid: recieverUid ?? "")
    }
    
    func getCellModel(at indexPath: IndexPath) -> CellChatModel {
        return chatList[indexPath.row]
    }
    
}
