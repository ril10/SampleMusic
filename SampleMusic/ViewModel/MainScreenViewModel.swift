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
import UIKit

class MainScreenViewModel {
        
    var db: Firestore!
    var reloadView : (() -> Void)?
    var error : ((Error) -> Void)?
    var dismisAlert : ((Bool) -> Void)?
    var loading : ((Bool) -> Void)?
    var loadCompleteUser : ((Bool) -> Void)?
    var loadCompleteSeller : ((Bool) -> Void)?
    
    func userSignIn(email: String,password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let e = error {
                self!.loading?(false)
                self?.error?(e)
            } else {
                self!.loading?(true)
                self?.currentUser()
            }
        }
        
    }
    
    func currentUser() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if ((user) != nil) {
                self?.db?.collection(Role.user.rawValue.lowercased()).document(user!.uid).addSnapshotListener { [weak self] doc, error in
                    if let e = error {
                        self?.error?(e)
                    } else {
                        if doc?.data() != nil {
                            self?.dismisAlert?(true)
                            self?.loadCompleteUser?(true)
                            self?.reloadView?()
                        }
                    }
                }
                self?.db?.collection(Role.seller.rawValue.lowercased()).document(user!.uid).addSnapshotListener { [weak self] doc, error in
                    if let e = error {
                        self?.error?(e)
                    } else {
                        if doc?.data() != nil {
                            self?.dismisAlert?(true)
                            self?.loadCompleteSeller?(true)
                            self?.reloadView?()
                        }
                    }
                }
            }
        }
    }
    
}
