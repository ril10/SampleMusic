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
    var fieldData : ((String,String,String,String,String) -> Void)?
    
    
    func userData(uid: String) {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.db.collection(Role.seller.rawValue.lowercased()).document(user?.uid ?? uid).addSnapshotListener { [weak self] doc, error in
                doc?.data().map {
                    for ( key, value ) in $0 {
                        print(key)
                        print(value)
                    }
                }
            }
        }
    }
    
    func logedUser() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.userData(uid: auth.currentUser!.uid)
        }
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
