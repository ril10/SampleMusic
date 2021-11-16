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
    
    
    
}
