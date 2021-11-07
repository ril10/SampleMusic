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

protocol ViewControllerImp : AnyObject {
    func userSignIn(email: String,password: String)
    var loading : ((Bool) -> Void)? { get set }
    var dismisAlert : ((Bool) -> Void)? { get set }
    var reloadView : (() -> Void)? { get set }
    var loadCompleteUser : ((Bool) -> Void)? { get set }
    var loadCompleteSeller : ((Bool) -> Void)? { get set }
    var error : ((Error) -> Void)? { get set }
}

protocol MainScreenImp : AnyObject {
    var viewModel : ViewControllerImp! { get set }
}

protocol FirebaseImp {
    var db : Firestore! { get set }
}

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            DependencyContainer.uiContainers = [container]
            
            container.register(.unique) { Firestore.firestore() as Firestore}
            container.register(.unique) { Storage.storage() }
            
            container.register(tag: "MainScreen") { MainScreenViewModel() as ViewControllerImp }
                        
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
