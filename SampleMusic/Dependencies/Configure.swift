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
            _ = appContainer
        }
    }
}
let appContainer = DependencyContainer { container in
    unowned let container = container
    container.register(.unique) { Storage.storage() as Storage }
    container.register(.unique) { Firestore.firestore() as Firestore }
    container.register(.unique) { MainScreenViewModel(db: try! container.resolve()) as MainControllerImp }
    container.register(.unique) { RegistrationViewModel(db: try! container.resolve()) as RegistrationControllerImp }
    container.register(.unique) { ListSampleViewModel(db: try! container.resolve()) as ListSamplesImp }
    container.register(.unique) { SellerDetailViewModel(db: try! container.resolve()) as SellerImp }
    container.register(.unique) { AddingDataAboutUserViewModel(db: try! container.resolve(), st: try! container.resolve()) as AddingDataImp }
    container.register(.unique) { UINavigationController() as UINavigationController }
    container.register(.unique) { TabBarControllerViewModel(db: try! container.resolve()) as TabBarImp }
    
    container.register(.unique) { MainScreenViewController(viewModel: try! container.resolve() as MainControllerImp) as MainScreenProtocol }
    container.register(.unique) { RegistrationViewController(viewModel: try! container.resolve() as RegistrationControllerImp) as RegistrationScreenProtocol }
    container.register(.unique) { ListSamplesViewController(viewModel: try! container.resolve() as ListSamplesImp) as ListSamplesScreenProtocol }
    container.register(.unique) { SellerDetailViewController(viewModel: try! container.resolve() as SellerImp) as SellerScreenProtocol }
    container.register(.unique) { AddingDataViewController(viewModel: try! container.resolve() as AddingDataImp) as AddingDataScreenProtocol }
    container.register(.unique) { TabBarController(viewModel: try! container.resolve() as TabBarImp,sellerController: try! container.resolve() as SellerScreenProtocol,listController: try! container.resolve() as ListSamplesScreenProtocol)
        as TabBarScreenProtocol }
    
    container.register(.unique) { MainScreenCoordinator(navigationController: try! container.resolve(), view: try! container.resolve()) }
    container.register(.unique) { MainCoordinator(navigationController: try! container.resolve(), mainView: try! container.resolve(),registrationView: try! container.resolve(),listView: try! container.resolve(),tabBar: try! container.resolve(),addingView: try! container.resolve() ) }
    container.register(.unique) { RegistrationCoordinator(navigationController: try! container.resolve(), view: try! container.resolve()) }
    container.register(.unique) { AddUserDataCoordinator(navigationController: try! container.resolve(), view: try! container.resolve()) }
    container.register(.unique) { ListSamplesCoordinator(navigationController: try! container.resolve(), view: try! container.resolve()) }
    container.register(.unique) { TabBarCoordinator(navigationController: try! container.resolve(), view: try! container.resolve()) }
    container.register(.unique) { SellerCoordinator(navigationController: try! container.resolve(), view: try! container.resolve()) }
}
