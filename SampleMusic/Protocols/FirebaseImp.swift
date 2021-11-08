//
//  FirebaseImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.11.21.
//

import Foundation
import FirebaseFirestore

protocol FirebaseImp {
    var db : Firestore! { get set }
}
