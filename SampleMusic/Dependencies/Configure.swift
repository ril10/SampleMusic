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
        }
    }
    static func configureAll() {
        _ = appContainer
        _ = signContainer
        _ = userContainer
    }
}
let appContainer = DependencyContainer { container in
    unowned let container = container
    container.register(.shared) { Storage.storage() as Storage }
    container.register(.shared) { Firestore.firestore() as Firestore }
    container.register(.singleton) { UINavigationController() as UINavigationController }
    container.register(.shared) { StartViewController() as StartViewProtocol }
}

let signContainer = DependencyContainer { container in
    unowned let container = container
    
    container.register(.unique) { AddUserDataCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { RegistrationCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.shared) { MainScreenCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    
    container.register(.shared) { MainScreenViewModel(db: try! appContainer.resolve()) as MainControllerImp }
    container.register(.shared) { RegistrationViewModel(db: try! appContainer.resolve()) as RegistrationControllerImp }
    container.register(.shared) { AddingDataAboutUserViewModel(db: try! appContainer.resolve(), st: try! appContainer.resolve()) as AddingDataImp }
    
    container.register(.singleton) { MainScreenViewController(viewModel: try! container.resolve() as MainControllerImp) as MainScreenProtocol }
    container.register(.singleton) { RegistrationViewController(viewModel: try! container.resolve() as RegistrationControllerImp) as RegistrationScreenProtocol }
    container.register(.singleton) { AddingDataViewController(viewModel: try! container.resolve() as AddingDataImp) as AddingDataScreenProtocol }
}

let userContainer = DependencyContainer { container in
    unowned let container = container
    
    container.register(.unique) { ListSamplesCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { TabBarCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { UploadMusicCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    
    container.register(.shared) { ListSampleViewModel(db: try! appContainer.resolve()) as ListSamplesImp }
    container.register(.shared) { SellerDetailViewModel(db: try! appContainer.resolve(),st: try! appContainer.resolve()) as SellerImp }
    container.register(.shared) { TabBarControllerViewModel(db: try! appContainer.resolve()) as TabBarImp }
    
    container.register(.shared) { UploadMusicViewController() as UploadMusicProtocol }
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
