//
//  SellerCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import Foundation
import UIKit
import FirebaseFirestore


class SellerCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SellerDetailViewController()
        vc.coordinator = parentCoordinator
        self.navigationController.pushViewController(vc, animated: true)
    }
}
