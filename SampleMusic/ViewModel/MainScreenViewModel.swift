//
//  MainScreenViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Dip

class MainScreenViewModel {
    
    var reloadView : (() -> Void)?
    var db : Firestore!
    var error : ((Error) -> Void)?
    var navUser : ((Bool) -> Void)?
    var navSeller : ((Bool) -> Void)?
    var loading : ((Bool) -> Void)?
    init(db: Firestore) {
        self.db = db
    }
    
    func userSignIn(email: String,password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let e = error {
                self!.loading?(false)
                self?.error?(e)
            } else {
                
                self!.loading?(true)
                self?.currentUser(uid: authResult!.user.uid)
            }
        }
        
    }
    
    func currentUser(uid: String) {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.db.collection(Role.user.rawValue.lowercased()).document(user?.uid ?? uid).addSnapshotListener { doc, error in
                if let e = error {
                    self.error?(e)
                } else {
                    if doc?.data() != nil {
                        self.navUser?(true)
                    }
                }
            }
            self.db.collection(Role.seller.rawValue.lowercased()).document(user?.uid ?? uid).addSnapshotListener { doc, error in
                if let e = error {
                    self.error?(e)
                } else {
                    if doc?.data() != nil {
                        self.navSeller?(true)
                    }
                }
            }
        }
    }
    
}
