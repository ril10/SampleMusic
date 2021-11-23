//
//  UploadMusicModelView.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 15.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import Dip

class UploadMusicViewModel: UploadMusicImp {

    var db: Firestore!
    var st: Storage!
    var reloadView : (() -> Void)?
    var loading: ((Bool) -> Void)?
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    func createSampleCollection() {
        self.db?.collection(Role.sample.rawValue.lowercased()).document().setData([
            "ownerUid":Auth.auth().currentUser?.uid as Any
        ])
    }
    
    func uploadSampleImage(image: Data,text: String) {
        createSampleCollection()
        let refrence = db.collection(Role.sample.rawValue.lowercased())
        let uploadTask = st?.reference().child("imageSamples/\(text).jpg").putData(image, metadata: nil) { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
        }

        uploadTask?.observe(.success) { snapshot in
            print(snapshot.progress!.completedUnitCount)
            self.st?.reference().child("imageSamples/\(text).jpg")
                .downloadURL { url, error in
                    if let error = error {
                        print(error)
                    } else {
                    refrence.whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid)
                            .getDocuments { query, error in
                                if let error = error {
                                    print(error.localizedDescription)
                                } else {
                                    refrence.document(query!.documents.last!.documentID).updateData([
                                        "sampleImageUrl":url?.absoluteString as Any,
                                    ])
                                }
                            }
                    }

                }
        }
        
        uploadTask?.observe(.failure) { snapshot in
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
    
    func addSampleName(text: String) {
        let refrence = db.collection(Role.sample.rawValue.lowercased())
        refrence.whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid)
                .getDocuments { query, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        refrence.document(query!.documents.last!.documentID).updateData([
                            "sampleName":text as Any
                        ])
                    }
                }
    }
    
    func uploadSample(sample: URL,text: String) {
        let refrence = db.collection(Role.sample.rawValue.lowercased())
        let uploadTask = st?.reference().child("musicSamples/\(text).m4a").putFile(from: sample)
        
        uploadTask?.observe(.success) { snapshot in
            print(snapshot.progress!.completedUnitCount)
            self.st?.reference().child("musicSamples/\(text).m4a")
                .downloadURL { url, error in
                    if let error = error {
                        print(error)
                    } else {
                        refrence.whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid)
                                .getDocuments { query, error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        refrence.document(query!.documents.last!.documentID).updateData([
                                            "sampleUrl":url?.absoluteString as Any
                                        ])
                                    }
                                }
                        self.loading?(true)
                    }
                }

        }
        
        uploadTask?.observe(.failure) { snapshot in
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
    
    
}
