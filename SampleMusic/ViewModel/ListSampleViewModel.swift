//
//  ListSampleViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Dip

class ListSampleViewModel: ContainerImp, ListSamplesImp {
    var container: DependencyContainer!
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var isLogout : ((Bool) -> Void)?
    
    func logout() {
            do {
                try Auth.auth().signOut()
                isLogout?(true)
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
    }
    
}
