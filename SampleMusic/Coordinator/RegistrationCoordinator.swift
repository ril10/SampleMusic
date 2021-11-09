//
//  RegistrationCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import UIKit


class RegistrationCoordinator : Coordinator {
    
    weak var parentCoordinator : MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RegistrationViewController()
        vc.coordinator = parentCoordinator
        self.navigationController.pushViewController(vc, animated: true)
    }

}
