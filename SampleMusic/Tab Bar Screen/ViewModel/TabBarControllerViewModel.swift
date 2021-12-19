//
//  TabControllerViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Dip
import RealmSwift

class TabBarControllerViewModel: TabBarImp {
    var recUid: String?
    
    var db: Firestore!
    var reloadView : (() -> Void)?
    let realm = try! Realm()
    var ownerUid : String?
    
    init (db: Firestore) {
        self.db = db
    }
    func logout() {
            do {
                try Auth.auth().signOut()
                try! realm.write({
                    realm.deleteAll()
                })
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
    }
    
    func getCurrentUser() {
        if let user = Auth.auth().currentUser {
            self.ownerUid = user.uid
        }
    }
    
    func checkToStart(completion:@escaping (Bool) -> Void?) {
        let dataState = realm.objects(State.self)
        if dataState.isEmpty {
            completion(true)
        }
    }
    
}
