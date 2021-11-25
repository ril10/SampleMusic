//
//  StartViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import RealmSwift


class StartViewModel: StartViewImp {
    var db : Firestore
    var isSignIn : ((Bool) -> Void)?
    init(db: Firestore) {
        self.db = db
    }
    let realm = try! Realm()
    var state : Results<State>?
    
    func checkUserStatus() {
       Auth.auth().addStateDidChangeListener({ auth, user in
            if let user = user {
                self.isSignIn?(true)
            } else {
                self.isSignIn?(false)
            }
        })
    }
    
    func loadState() {
        state = realm.objects(State.self)
    }
    
}
