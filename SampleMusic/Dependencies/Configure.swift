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
            _ = appContainer
            _ = signContainer
            _ = userContainer
        }
    }
}
let appContainer = DependencyContainer { container in
    unowned let container = container
    container.register(.unique) { Storage.storage() as Storage }
    container.register(.unique) { Firestore.firestore() as Firestore }

    container.register(.singleton) { UINavigationController() as UINavigationController }

    container.register(.unique) {
        MainCoordinator(
            navigationController: try! container.resolve(),
            mainView: try! container.resolve(),
            registrationView: try! container.resolve(),
            listView: try! container.resolve(),
            tabBar: try! container.resolve(),
            addingView: try! container.resolve() )
    }
    

}

let signContainer = DependencyContainer { container in
    unowned let container = container
    
    container.register(.unique) { AddUserDataCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { RegistrationCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { MainScreenCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    
    container.register(.unique) { MainScreenViewModel(db: try! appContainer.resolve()) as MainControllerImp }
    container.register(.unique) { RegistrationViewModel(db: try! appContainer.resolve()) as RegistrationControllerImp }
    container.register(.unique) { AddingDataAboutUserViewModel(db: try! appContainer.resolve(), st: try! appContainer.resolve()) as AddingDataImp }
    
    container.register(.singleton) { MainScreenViewController(viewModel: try! container.resolve() as MainControllerImp) as MainScreenProtocol }
    container.register(.singleton) { RegistrationViewController(viewModel: try! container.resolve() as RegistrationControllerImp) as RegistrationScreenProtocol }
    container.register(.singleton) { AddingDataViewController(viewModel: try! container.resolve() as AddingDataImp) as AddingDataScreenProtocol }
}

let userContainer = DependencyContainer { container in
    unowned let container = container
    
    container.register(.unique) { ListSamplesCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { TabBarCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    
    container.register(.unique) { ListSampleViewModel(db: try! appContainer.resolve()) as ListSamplesImp }
    container.register(.unique) { SellerDetailViewModel(db: try! appContainer.resolve()) as SellerImp }
    container.register(.unique) { TabBarControllerViewModel(db: try! appContainer.resolve()) as TabBarImp }
    
    container.register(.singleton) { ListSamplesViewController(viewModel: try! container.resolve() as ListSamplesImp) as ListSamplesScreenProtocol }
    container.register(.singleton) { SellerDetailViewController(viewModel: try! container.resolve() as SellerImp) as SellerScreenProtocol }
    container.register(.singleton) {
        TabBarController(
            viewModel: try! container.resolve() as TabBarImp,
            sellerController: try! container.resolve() as SellerScreenProtocol,
            listController: try! container.resolve() as ListSamplesScreenProtocol)
            as TabBarScreenProtocol
    }
}
