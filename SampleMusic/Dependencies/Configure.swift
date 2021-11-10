//
//  Configure.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import Foundation
import Dip
import Firebase
import FirebaseFirestore
import FirebaseStorage
import UIKit

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            print(appContainer)
            appContainer.register(.unique) { MainScreenViewController(
                viewModel: try! container.resolve() as MainControllerImp,
                coordinator: try! container.resolve() as MainCoordinatorImp
            ) as! MainScreenProtocol }
            appContainer.register(.unique) { RegistrationViewController() }
            
            _ = appContainer
        }
    }
}
let appContainer = DependencyContainer { container in
    unowned let container = container
    container.register(.unique) { Storage.storage() as Storage }
    container.register(.unique) { Firestore.firestore() as Firestore }
    container.register(.unique) { MainScreenViewModel() as MainControllerImp }
    container.register(.unique) { RegistrationViewModel() as RegistrationControllerImp }
    container.register(.unique) { ListSampleViewModel() as ListSamplesImp }
    container.register(.unique) { SellerDetailViewModel() as SellerImp }
    container.register(.unique) { AddingDataAboutUserViewModel() as AddingDataImp }
    container.register(.unique) { MainCoordinator(navigationController: UINavigationController()) as MainCoordinatorImp }
    container.register(.unique) { ListSamplesViewController() }
    container.register(.unique) { TabBarControllerViewModel() as TabBarImp }


}
