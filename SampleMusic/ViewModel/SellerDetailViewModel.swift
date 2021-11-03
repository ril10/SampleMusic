//
//  SellerDetailViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.10.21.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import Dip


class SellerDetailViewModel {
    
    init(db: Firestore) {
        self.db = db
    }
    
    var reloadView : (() -> Void)?
    var db : Firestore!
    var isLogout : ((Bool) -> Void)?
    
    
    func userData() {
        if Auth.auth().currentUser != nil {
            print("sign")
        } else {
            print("not sign")
        }
    }
    
    func logout() {
            do {
                try Auth.auth().signOut()
                isLogout?(true)
                reloadView?()
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
    }
}
