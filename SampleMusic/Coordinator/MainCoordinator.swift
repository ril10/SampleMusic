//
//  MainCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class MainCoordinator: Coordinator, MainCoordinatorImp {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let child = MainScreenCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        self.childCoordinators.append(child)
        child.start()
    }
    
    func logout() {
        self.navigationController.dismiss(animated: true) {
            self.childCoordinators.removeAll()
            self.start()
        }
    }
    
    func registrationViewController() {
        let child = RegistrationCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        self.childCoordinators.append(child)
        child.start()
    }
    
    func mainTabController() {
        let child = TabBarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func userList() {
        let child = ListSamplesCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func addUserData(role: String,docId: String) {
        let child = AddUserDataCoordinator(navigationController: navigationController)
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
