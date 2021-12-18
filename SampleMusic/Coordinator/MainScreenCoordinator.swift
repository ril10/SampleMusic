//
//  MainScreenCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 11.11.21.
//

import UIKit
import Dip

class MainScreenCoordinator : Coordinator {
    var view: MainScreenProtocol
    
    var childCoordinators = [Coordinator]()
    var parentCoordinator : MainCoordinator?
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController,view: MainScreenProtocol) {
        self.navigationController = navigationController
        self.view = view
    }

    func start() {
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func finish() {
        navigationController.viewControllers.removeLast()
        parentCoordinator?.childDidFinish(self)
    }
    
    func goToRegistrationPage() {
//        navigationController.viewControllers.removeLast()
        self.parentCoordinator?.childDidFinish(self)
        self.parentCoordinator!.registrationViewController()
    }
    
    func goToSeller() {
//        navigationController.viewControllers.removeLast()
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.mainTabController()
        
    }
    
    func goToUser() {
//        navigationController.viewControllers.removeLast()
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.userList()
    }
}
