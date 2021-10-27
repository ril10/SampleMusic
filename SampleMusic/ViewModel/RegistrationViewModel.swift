//
//  RegistrationViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Dip

class RegistrationViewModel {
    
    var reloadView : (() -> Void)?
    var error : ((Error) -> Void)?
    var roleSet : String!
    var navToAdd : ((Bool) -> Void)?
    
    init(db: Firestore) {
        self.db = db
    }
    
    var db : Firestore!
    
    func registerUser(email: String,password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.error?(e)
            } else {
                self.db.collection(self.roleSet).addDocument(data: ["email":email,"uid":authResult?.user.uid]) { error in
                    if let e = error {
                        self.error?(e)
                    }
                }
                self.navToAdd?(true)
            }
        }
    }
    
    func roleChoose(_ role: String) {
        roleSet = role
    }
    
}
