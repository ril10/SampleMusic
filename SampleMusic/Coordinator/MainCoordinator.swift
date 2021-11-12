//
//  MainCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import Dip

class MainCoordinator: Coordinator, MainCoordinatorImp {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,
         mainView: MainScreenProtocol,
         registrationView: RegistrationScreenProtocol,
         listView: ListSamplesScreenProtocol,
         tabBar: TabBarScreenProtocol,
         addingView: AddingDataScreenProtocol,
         startView: StartViewProtocol) {
        self.navigationController = navigationController
        self.mainView = mainView
        self.registrationView = registrationView
        self.listView = listView
        self.tabBar = tabBar
        self.addingView = addingView
        self.startView = startView
    }
    
    var startView : StartViewProtocol
    var mainView : MainScreenProtocol
    var registrationView : RegistrationScreenProtocol
    var addingView : AddingDataScreenProtocol
    var listView : ListSamplesScreenProtocol
    var tabBar : TabBarScreenProtocol
    
    func start() {
        startView = try! appContainer.resolve() as StartViewProtocol
        startView.coordinator = self
        self.navigationController.pushViewController(startView, animated: true)
    }
    
    func mainScreenView() {
        let child = try! signContainer.resolve() as MainScreenCoordinator
        child.parentCoordinator = self
        self.childCoordinators.append(child)
        child.start()
    }
    
    func registrationViewController() {
        let child = try! signContainer.resolve() as RegistrationCoordinator
        child.parentCoordinator = self
        self.childCoordinators.append(child)
        child.start()
    }
    
    func mainTabController() {
        let child = try! userContainer.resolve() as TabBarCoordinator
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func userList() {
        let child = try! userContainer.resolve() as ListSamplesCoordinator
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func addUserData(role: String,docId: String) {
        let child = try! userContainer.resolve() as AddUserDataCoordinator
        child.parentCoordinator = self
        child.docId = docId
        child.roleSet = role
        childCoordinators.append(child)
        child.start()
    }
    
    func tabBarFinish() {
        navigationController.viewControllers = []
    }
    
}
