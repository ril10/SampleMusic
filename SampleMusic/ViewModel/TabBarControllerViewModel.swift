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
    var db: Firestore!
    var reloadView : (() -> Void)?
    let realm = try! Realm()
    
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
    
}
