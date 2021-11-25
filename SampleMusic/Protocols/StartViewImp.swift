//
//  StartViewImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.11.21.
//

import Foundation
import FirebaseFirestore

protocol StartViewImp {
    func checkUserStatus()
    var isSignIn : ((Bool) -> Void)? { get set }
    func loadState()
}
