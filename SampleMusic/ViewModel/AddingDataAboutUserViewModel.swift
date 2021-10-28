//
//  AddingDataAboutUserViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 27.10.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase
import Dip

class AddingDataAboutUserViewModel {
    
    init(db: Firestore) {
        self.db = db
    }
    
    var roleSet : String!
    
    var db : Firestore!
    var gender : String!
    
    var reloadView : (() -> Void)?
    
    func currentUser(firstName: String,LastName: String,description: String) {
        Auth.auth().addStateDidChangeListener { auth, user in
            auth.currentUser?.createProfileChangeRequest().commitChanges(completion: { error in
                if let e = error {
                    
                } else {
                    self.db.collection(self.roleSet).document(user!.uid).setData([
                        "firstName":firstName,
                        "lastName":LastName,
                        "description":description,
                        "gender":self.gender
                    ])
                }
            })
        }
    }
    
    func uploadImage() {
        
    }
    
    func genderSet(gender: String) {
        self.gender = gender
    }
    
    
}
