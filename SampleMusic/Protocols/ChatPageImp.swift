//
//  ChatPageImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 30.11.21.
//

import Foundation
import FirebaseFirestore

protocol ChatPageImp {
    var reloadTableView : (() -> Void)? { get set }
    var db : Firestore { get set }
    func loadMessages()
    var chatList : [CellChatModel] { get set }
    func getCellModel(at indexPath: IndexPath) -> CellChatModel
    func ifUserSign()
    func ifSellerSign()
    var userSign : ((Bool) -> Void)? { get set }
    var sellerSign : ((Bool) -> Void)? { get set }
    func loadMessageIfUser()
}
