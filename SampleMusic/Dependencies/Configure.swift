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

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            DependencyContainer.uiContainers = [container]
            _ = appContainer
        }
    }
}
let appContainer : DependencyContainer = {
    let container = DependencyContainer()
    container.register(.unique) { Storage.storage() as Storage }
    container.register(.unique) { Firestore.firestore() as Firestore }
    container.register(.unique) { MainScreenViewModel() as MainControllerImp }
    container.register(.unique) { RegistrationViewModel() as RegistrationControllerImp }
    container.register(.unique) { ListSampleViewModel() as ListSamplesImp }
    container.register(.unique) { SellerDetailViewModel() as SellerImp }
    container.register(.unique) { AddingDataAboutUserViewModel() as AddingDataImp }
    return container
}()

