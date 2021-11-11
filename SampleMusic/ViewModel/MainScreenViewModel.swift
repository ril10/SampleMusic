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

class MainScreenViewModel: MainControllerImp {
    var db: Firestore!
    var reloadView : (() -> Void)?
    var error : ((Error) -> Void)?
    var dismisAlert : ((Bool) -> Void)?
    var loading : ((Bool) -> Void)?
    var loadCompleteUser : ((Bool) -> Void)?
    var loadCompleteSeller : ((Bool) -> Void)?
    
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
                self?.sellerSign()
                self?.userSign()
            }
        }
        
    }
    
    func userSign() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if ((user) != nil) {
                self?.db?.collection(Role.user.rawValue.lowercased()).document(user!.uid).addSnapshotListener { [weak self] doc, error in
                    if let e = error {
                        self?.error?(e)
                    } else {
                        if doc?.data() != nil {
                            self?.dismisAlert?(true)
                            self?.loadCompleteUser?(true)
                        }
                    }
                }
            }
        }
    }
    func sellerSign() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if ((user) != nil) {
                self?.db?.collection(Role.seller.rawValue.lowercased()).document(user!.uid).addSnapshotListener { [weak self] doc, error in
                    if let e = error {
                        self?.error?(e)
                    } else {
                        if doc?.data() != nil {
                            self?.dismisAlert?(true)
                            self?.loadCompleteSeller?(true)
                        }
                    }
                }
            }
        }
    }
    
    func isUserSign() {
        if Auth.auth().currentUser != nil {
            print("User is signIn")
        } else {
            print("User isn't signIn")
        }
    }
    
}
