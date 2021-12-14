//
//  UserDetailViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import RealmSwift


class UserDetailViewModel: UserDetailViewModelImp  {
    
    var reloadView: (() -> Void)?
    var fieldData: ((String, String, String, String, String, String) -> Void)?
    var image: ((Data) -> Void)?
    var dismissAlert: ((Bool) -> Void)?
    var db : Firestore?
    var st : Storage?
    
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    
    func userData() {
        if let user = Auth.auth().currentUser {
            self.db?.collection(Role.user.rawValue.lowercased()).document(user.uid).getDocument(completion: { (document, error) in
                if let data = document?.data() {
                    let sellerData = DetailModel(data: data)
                    self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender,sellerData.imageUrl)
                    self.dismissAlert?(true)
                }
            })
        }
    }
    
}
