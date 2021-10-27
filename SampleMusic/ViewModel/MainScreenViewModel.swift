//
//  MainScreenViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import Foundation
import FirebaseAuth
import Dip

class MainScreenViewModel {
    
    var reloadView : (() -> Void)?
    
    var error : ((Error) -> Void)?
    
    func userSignIn(email: String,password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if let e = error {
                self?.error?(e)
            }
        }
    }
    
}
