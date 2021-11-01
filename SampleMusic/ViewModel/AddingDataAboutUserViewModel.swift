//
//  AddingDataAboutUserViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 27.10.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import Dip

class AddingDataAboutUserViewModel {
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    var roleSet : String!
    var db : Firestore!
    var st : Storage!
    var gender : String!
    var reloadView : (() -> Void)?
    var docId : String!
    var navSeller : ((Bool) -> Void)?
    var navUser : ((Bool) -> Void)?
    var loading : ((Bool) -> Void)?
    
    func currentUser(firstName: String,LastName: String,description: String) {
        Auth.auth().addStateDidChangeListener { auth, user in
            auth.currentUser?.createProfileChangeRequest().commitChanges(completion: { error in
                if error != nil {
                    
                } else {
                    self.db.collection(self.roleSet).document(self.docId!).updateData([
                        "firstName":firstName,
                        "lastName":LastName,
                        "description":description,
                        "gender":self.gender as Any
                    ])
                }
            })
        }
    }
    
    func uploadImage(image: Data) {
        let uploadTask = st.reference().child("userAvatars/\(self.docId!).png").putData(image, metadata: nil) { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            
            self.st.reference().child("userAvatars/\(self.docId!).png")
                .downloadURL { url, error in
                    if let error = error {
                        print(error)
                    } else {
                        self.db.collection(self.roleSet).document(self.docId!).updateData([
                            "imageUrl":url?.absoluteString as Any
                        ])
                    }
                    
                }
        }

        uploadTask.observe(.success) { snapshot in
            print(snapshot.progress!.completedUnitCount)
            if self.roleSet == "seller" {
                self.loading?(true)
                self.navSeller?(true)
            } else {
                self.loading?(true)
                self.navUser?(true)
            }
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    print("File not exist")
                    break
                case .unauthorized:
                    print("Not authorized")
                    break
                default:
                    break
                }
            }
        }
    }
    
    func genderSet(gender: String) {
        self.gender = gender
    }
    
    
}
