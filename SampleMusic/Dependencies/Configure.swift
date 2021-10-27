//
//  Configure.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import Foundation
import Dip
import FirebaseFirestore

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            
            
            container.register(.unique) { MainScreenViewController(viewModel: MainScreenViewModel()) }
            container.register(.unique) { RegistrationViewController(viewModel: RegistrationViewModel(db: Firestore.firestore())) }

            
            DependencyContainer.uiContainers = [container]
        }
    }
}
