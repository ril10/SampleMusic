//
//  RegistrationViewModel.swift
//  SampleMusic
//
//  Created by administrator on 26.10.21.
//

import Foundation
import FirebaseAuth
import Dip

class RegistrationViewModel {
    
    var reloadView : (() -> Void)?
    var error : ((Error) -> Void)?
    
    func registerUser(email: String,password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.error?(e)
            }
        }
    }
    

    
}
