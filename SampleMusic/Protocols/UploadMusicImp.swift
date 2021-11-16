//
//  UploadMusicImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 16.11.21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

protocol UploadMusicImp {
    
    var db: Firestore! { get set }
    var st: Storage! { get set }
    var reloadView : (() -> Void)? { get set }
    
    
    
}
