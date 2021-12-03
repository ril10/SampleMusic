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
    container.register(.singleton) { Storage.storage() as Storage }
    container.register(.singleton) { Firestore.firestore() as Firestore }
    container.register(.singleton) { UINavigationController() as UINavigationController }
    container.register(.shared) { StartViewController() as StartViewProtocol }
    container.register(.shared) { MusicPlayer() as MusicPlayerProtocol }
}

let signContainer = DependencyContainer { container in
    unowned let container = container
    
    container.register(.unique) { AddUserDataCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { RegistrationCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.shared) { MainScreenCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    
    container.register(.shared) { MainScreenViewModel(db: try! appContainer.resolve()) as MainControllerImp }
    container.register(.shared) { RegistrationViewModel(db: try! appContainer.resolve()) as RegistrationControllerImp }
    container.register(.shared) { AddingDataAboutUserViewModel(db: try! appContainer.resolve(), st: try! appContainer.resolve()) as AddingDataImp }
    
    container.register(.shared) { MainScreenViewController(viewModel: try! container.resolve() as MainControllerImp) as MainScreenProtocol }
    container.register(.shared) { RegistrationViewController(viewModel: try! container.resolve() as RegistrationControllerImp) as RegistrationScreenProtocol }
    container.register(.shared) { AddingDataViewController(viewModel: try! container.resolve() as AddingDataImp) as AddingDataScreenProtocol }
}

let userContainer = DependencyContainer { container in
    unowned let container = container
    
    container.register(.unique) { ListSamplesCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { TabBarCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { UploadMusicCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { UserDetailCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { RecordPageCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { ChatPageCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { ChatDetailCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    container.register(.unique) { SellerDetailCoordinator(navigationController: try! appContainer.resolve(), view: try! container.resolve()) }
    
    container.register(.shared) { ListSampleViewModel(db: try! appContainer.resolve(),st: try! appContainer.resolve()) as ListSamplesImp }
    container.register(.shared) { SellerDetailViewModel(db: try! appContainer.resolve(),st: try! appContainer.resolve()) as SellerImp }
    container.register(.shared) { TabBarControllerViewModel(db: try! appContainer.resolve()) as TabBarImp }
    container.register(.shared) { UploadMusicViewModel(db: try! appContainer.resolve(), st: try! appContainer.resolve()) as UploadMusicImp }
    container.register(.shared) { UserDetailViewModel(db: try! appContainer.resolve(), st: try! appContainer.resolve()) as UserDetailViewModelImp }
    container.register(.shared) { RecordPageViewModel(db: try! appContainer.resolve(), st: try! appContainer.resolve()) as RecordViewModelImp }
    container.register(.shared) { ChatDetailViewModel(db: try! appContainer.resolve(), st: try! appContainer.resolve()) as ChatDetailimp }
    container.register(.shared) { ChatPageViewModel(db: try! appContainer.resolve()) as ChatPageImp }
    
    container.register(.shared) { ChatDetailViewController(viewModel: try! container.resolve() as ChatDetailimp) as ChatDetailProtocol }
    container.register(.shared) { ChatPageViewController(viewModel: try! container.resolve() as ChatPageImp) as ChatPageProtocol }
    container.register(.shared) { RecordPageViewController(viewModel: try! container.resolve() as RecordViewModelImp) as RecordPageProtocol }
    container.register(.shared) { UserDetailViewController(viewModel: try! container.resolve() as UserDetailViewModelImp) as UserDetailProtocol }
    container.register(.shared) { UploadMusicViewController(viewModel: try! container.resolve() as UploadMusicImp) as UploadMusicProtocol }
    container.register(.shared) { ListSamplesViewController(viewModel: try! container.resolve() as ListSamplesImp) as ListSamplesScreenProtocol }
    container.register(.shared) { SellerDetailViewController(viewModel: try! container.resolve() as SellerImp) as SellerScreenProtocol }
    container.register(.shared) {
        TabBarController(
            viewModel: try! container.resolve() as TabBarImp,
            sellerController: try! container.resolve() as SellerScreenProtocol,
            listController: try! container.resolve() as ListSamplesScreenProtocol)
            as TabBarScreenProtocol
    }
}
