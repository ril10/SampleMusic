//
//  MainScreenCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import UIKit

class MainScreenCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator : MainCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainScreenViewController()
        vc.coordinator = parentCoordinator
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
