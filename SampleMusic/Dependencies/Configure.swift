//
//  Configure.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import Foundation
import Dip
import FirebaseFirestore
import FirebaseStorage

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            
            
            container.register(.unique) { MainScreenViewController(viewModel: MainScreenViewModel(db: Firestore.firestore())) }
            container.register(.unique) { RegistrationViewController(viewModel: RegistrationViewModel(db: Firestore.firestore())) }
            container.register(.unique) { AddingDataAboutUserViewModel(db: Firestore.firestore(), st: Storage.storage()) }

            
            DependencyContainer.uiContainers = [container]
        }
    }
}
