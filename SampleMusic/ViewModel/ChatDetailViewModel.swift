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


class ChatDetailViewModel: ChatDetailimp {
    
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    
    init(db: Firestore) {
        self.db = db
    }
    
    func loadMessages() {
        
    }
    
    func sendMessage(text: String) {
        if let user = Auth.auth().currentUser {
            self.db?.collection(Role.message.rawValue).document().setData([
                "message":text as Any,
                "sendDate": Date().timeIntervalSince1970,
                "ownerUid": user.uid as Any
                
            ])
        }
    }
    
}
