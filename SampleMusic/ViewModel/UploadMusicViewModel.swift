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
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    
    func uploadSampleImage(image: Data,text: String) {
        let uploadTask = st?.reference().child("imageSamples/\(text).jpg").putData(image, metadata: nil) { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            
//            self.st?.reference().child("userAvatars/\(text).jpg")
//                .downloadURL { url, error in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        self.db?.collection(self.roleSet).document(self.docId!).updateData([
//                            "imageUrl":url?.absoluteString as Any
//                        ])
//                    }
//
//                }
        }

        uploadTask?.observe(.success) { snapshot in
            print(snapshot.progress!.completedUnitCount)
            
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
    
    func uploadSample(sample: URL,text: String) {
        let uploadTask = st?.reference().child("musicSamples/\(text).mp3").putFile(from: sample)
        
        uploadTask?.observe(.success) { snapshot in
            print(snapshot.progress!.completedUnitCount)
            
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
