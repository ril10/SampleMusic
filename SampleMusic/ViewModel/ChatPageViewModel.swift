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
        self.db.collection(Role.chatRoom.rawValue)
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
