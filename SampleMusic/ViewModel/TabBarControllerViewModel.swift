//
//  TabControllerViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Dip

class TabBarControllerViewModel: ContainerImp, TabBarImp, FirebaseImp {
    var db: Firestore!
    var container: DependencyContainer!
    var reloadView : (() -> Void)?
    
    init () {
        self.container = appContainer
        self.db = try! container.resolve() as Firestore
    }
    func logout() {
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
    }
    
}
