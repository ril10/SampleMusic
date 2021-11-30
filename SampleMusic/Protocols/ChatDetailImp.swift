//
//  ChatDetailImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.11.21.
//

import Foundation
import FirebaseFirestore

protocol ChatDetailimp {
    var db : Firestore? { get set }
    var reloadTableView : (() -> Void)? { get set }
    func sendMessage(text: String)
    var messageData : [Message] { get set }
    func loadMessages()
    func getCellModel(at indexPath: IndexPath) -> Message
    var hidden : ((Bool) -> Void)? { get set }
    func checkUser()
}
