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
import AVFoundation

class UploadMusicViewModel: UploadMusicImp {


    var db: Firestore!
    var st: Storage!
    var reloadView : (() -> Void)?
    var loading: ((Bool) -> Void)?
    var imageSampleUrl : String?
    var sampleName : String?
    var sampleUrl : String?
    var sampleDuration : Int?
    var type : String?
    var cost : Int?
    var isType : Bool?
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    func createSampleCollection() {
        let ref = self.db?.collection(Collection.sample.getCollection()).document()
        let id = ref?.documentID
        ref?.setData([
            "ownerUid":Auth.auth().currentUser?.uid as Any,
            "sampleImageUrl":self.imageSampleUrl as Any,
            "sampleName":self.sampleName as Any,
            "sampleUrl":self.sampleUrl as Any,
            "duration":self.sampleDuration as Any,
            "index":0 as Any,
            "type": self.type as Any,
            "cost": cost ?? 0 as Any,
            "id": id as Any,
        ])
    }
    
    
    func uploadSampleImage(image: Data,text: String) {
        let refrence = db.collection(Collection.sample.getCollection())
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
                                    self.imageSampleUrl = url?.absoluteString
                                    self.createSampleCollection()
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
        let refrence = db.collection(Collection.sample.getCollection())
        refrence.whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid)
                .getDocuments { query, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.sampleName = text
                    }
                }
    }
    
    func addSampleCost(text: String) {
        let refrence = db.collection(Collection.sample.getCollection())
        refrence.whereField("ownerUid", isEqualTo: Auth.auth().currentUser!.uid)
                .getDocuments { query, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        self.cost = Int(text) ?? 0
                    }
                }
    }
    
    func typeSet(_ type: String) {
        self.type = type
    }
    
    func uploadSample(sample: URL,text: String) {
        let refrence = db.collection(Collection.sample.getCollection())
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
                                        self.sampleUrl = url?.absoluteString
                                        let asset = AVAsset(url: url!)
                                        self.sampleDuration = Int(CMTimeGetSeconds(asset.duration))
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
