//
//  AddUserDataCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import UIKit
import Dip


class AddUserDataCoordinator : Coordinator {
    var view: AddingDataScreenProtocol
    
    
    weak var parentCoordinator : MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var docId : String!
    var roleSet : String!
    
    init(navigationController: UINavigationController,view: AddingDataScreenProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.viewModel?.docId = self.docId
        view.viewModel?.roleSet = self.roleSet
        view.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(view, animated: true)
    }

    func finish() {
        self.parentCoordinator?.childDidFinish(self)
    }
    
    func goToSeller() {
        navigationController.viewControllers.removeLast()
        self.parentCoordinator?.childDidFinish(self)
        self.parentCoordinator?.mainTabController()
    }
    
    func goToUser() {
        navigationController.viewControllers.removeLast()
        self.parentCoordinator?.childDidFinish(self)
        self.parentCoordinator?.userList()
    }
}
