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
}
