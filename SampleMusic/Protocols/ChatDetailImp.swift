//
//  ChatDetailImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol ChatDetailimp {
    var reloadTableView : (() -> Void)? { get set }
    func sendMessage(text: String)
    var messageData : [Message] { get set }
    func loadMessages()
    func getCellModel(at indexPath: IndexPath) -> Message
    var ownerUid : String? { get set }
    var chatRoom : String? { get set }
    var recieverUid : String? { get set }
    func checkCurrentUser() -> String
}
