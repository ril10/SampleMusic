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
        }
    }
    static func configureAll() {
        _ = mainScreenContainer
        _ = firestoreContainer
        _ = registrationScreenContainer
        _ = listSamplesContainer
        _ = sellerDetailContainer
        _ = addingDataContainer
        _ = storageContainer
    }
}
//MARK: - Firebase
let storageContainer : DependencyContainer = {
    let container = DependencyContainer()
    container.register(.unique) { Storage.storage() as Storage }
    container.register(.unique) { Firestore.firestore() as Firestore }
    return container
}()

let firestoreContainer : DependencyContainer = {
    let container = DependencyContainer()
    container.register(.unique) { Firestore.firestore() as Firestore }
    return container
}()
//MARK: - MainScreen
let mainScreenContainer: DependencyContainer = {
    let container = DependencyContainer()
    container.register(.unique) { MainScreenViewModel() as MainControllerImp }
    return container
}()

//MARK: - RegistrationScreen
let registrationScreenContainer: DependencyContainer = {
    let container = DependencyContainer()
    container.register(.unique) { RegistrationViewModel() as RegistrationControllerImp }
    return container
}()

//MARK: - ListSamples
let listSamplesContainer: DependencyContainer = {
    let container = DependencyContainer()
    container.register(.unique) { ListSampleViewModel() as ListSamplesImp }
    return container
}()

//MARK: - SellerDetail
let sellerDetailContainer: DependencyContainer = {
    let container = DependencyContainer()
    container.register(.unique) { SellerDetailViewModel() as SellerImp }
    return container
}()

//MARK: - AddingData
let addingDataContainer: DependencyContainer = {
    let container = DependencyContainer()
    container.register(.unique) { AddingDataAboutUserViewModel() as AddingDataImp }
    return container
}()


