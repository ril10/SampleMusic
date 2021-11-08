//
//  MainCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainScreenViewController()
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
        self.navigationController.dismiss(animated: true) {
            self.childDidFinish(self)
        }
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func registrationViewController() {
        let vc = RegistrationViewController()
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
        if navigationController.isBeingDismissed {
            childDidFinish(self)
        }
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
        let vc = AddingDataViewController()
        vc.viewModel?.roleSet = role
        vc.viewModel?.docId = docId
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func didLogout() {
        childDidFinish(self)
    }

}
