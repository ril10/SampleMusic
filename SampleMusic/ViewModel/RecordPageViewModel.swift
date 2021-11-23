//
//  RecordPageViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class RecordPageViewModel: RecordViewModelImp {
    
    var db: Firestore!
    var st: Storage!
    var reloadView: (() -> Void)?
    var loading: ((Bool) -> Void)?
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    func uploadSample(sample: URL, text: String) {
        
    }
    
    func uploadSampleImage(image: Data, text: String) {
        
    }

    func addSampleName(text: String) {
        
    }
    
    func createSampleCollection() {
        
    }
    
    
    
    
}
