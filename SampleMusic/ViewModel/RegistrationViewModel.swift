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

class RegistrationViewModel: RegistrationControllerImp,ContainerImp {
    
    var reloadView : (() -> Void)?
    var error : ((Error) -> Void)?
    var roleSet : String!
    var docId : String!
    var navToAdd : ((Bool) -> Void)?
    var isRole : Bool!
    var loading : ((Bool) -> Void)?
    var container : DependencyContainer!
    var db : Firestore?
    
    init() {
        self.container = firestoreContainer
        self.db = try! container.resolve()
    }
    
    func registerUser(email: String,password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.error?(e)
                self.loading?(false)
            } else {
                self.db?.collection(self.roleSet).document((authResult?.user.uid)!).setData(["email":email,"uid":authResult?.user.uid as Any]) { error in
                    if let e = error {
                        self.error?(e)
                    } else {
                        
                    }
                }
                self.docId = authResult?.user.uid
                self.loading?(true)
                self.navToAdd?(true)
            }
        }
    }
    
    func roleChoose(_ role: String) {
        roleSet = role
    }
    
}
