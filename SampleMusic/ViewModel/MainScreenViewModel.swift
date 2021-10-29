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
    
    var error : ((Error) -> Void)?
    
    func userSignIn(email: String,password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let e = error {
                self?.error?(e)
            } else {
                print("Succes")
                self?.currentUser()
            }
        }
        
    }
    
    func currentUser() {
        Auth.auth().addStateDidChangeListener { auth, user in
            print(user?.uid)
        }
    }
    
}
