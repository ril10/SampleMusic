//
//  AddUserDataCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import UIKit


class AddUserDataCoordinator : Coordinator {
    
    weak var parentCoordinator : MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var docId : String!
    var roleSet : String!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = AddingDataViewController()
        vc.viewModel?.docId = self.docId
        vc.viewModel?.roleSet = self.roleSet
        vc.coordinator = parentCoordinator
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }

}
