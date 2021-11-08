//
//  ListSamplesCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 4.11.21.
//

import UIKit
import FirebaseFirestore

class ListSamplesCoordinator : Coordinator {
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ListSamplesViewController()
        vc.coordinator = parentCoordinator
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
}
