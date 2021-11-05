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
    
    
    var reloadView : (() -> Void)?
    var db : Firestore?
    var isLogout : ((Bool) -> Void)?
    var fieldData : ((String,String,String,String,String) -> Void)?
    
    
    func userData() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if ((user) != nil) {
                self?.db?.collection(Role.seller.rawValue.lowercased()).document(user!.uid).addSnapshotListener { [weak self] doc, error in
                    doc?.data().map {
                        for ( key, value ) in $0 {

                        }
                    }
                }
            }
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
