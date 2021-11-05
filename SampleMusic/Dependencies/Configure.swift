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
import RxCocoa

protocol MainView {
    var viewModel : MainScreenViewModel! { get set }
}

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            DependencyContainer.uiContainers = [container]
            
            container.register(.unique) { Firestore.firestore() as Firestore}
            container.register(.unique) { Storage.storage() }
            
            container.register(.unique) { MainScreenViewModel() as MainScreenViewModel}
            .resolvingProperties { container, service in
                service.db = try! container.resolve()
            }
            
            container.register(.unique) { MainScreenViewController() }
            .resolvingProperties { container, service in
                service.viewModel = try! container.resolve()
            }
            
            container.register(.unique) { RegistrationViewModel() }
            .resolvingProperties { container, service in
                service.db = try! container.resolve()
            }
            
            container.register(.unique) { AddingDataAboutUserViewModel() }
            .resolvingProperties { container, service in
                service.db = try! container.resolve()
                service.st = try! container.resolve()
            }
            
            container.register(.unique) { SellerDetailViewModel() }
            .resolvingProperties { container, service in
                service.db = try! container.resolve()
            }
            
            container.register(.unique) { ListSampleViewModel() }
            .resolvingProperties { container, service in
                service.db = try! container.resolve()
            }
        }
    }
}
