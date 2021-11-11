//
//  ListSampleViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Dip

class ListSampleViewModel: ListSamplesImp {

    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var isLogout : ((Bool) -> Void)?
    init (db: Firestore) {
        self.db = db
    }
    func logout() {
            do {
                try Auth.auth().signOut()
                isLogout?(true)
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
    }
    
}
