//
//  TabBarCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 4.11.21.
//

import UIKit


class TabBarCoordinator : Coordinator {
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let vc = TabBarController()
        vc.coordinator = parentCoordinator
        self.navigationController.pushViewController(vc, animated: true)
    }
}
