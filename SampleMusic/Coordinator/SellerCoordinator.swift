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
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SellerDetailViewController(viewModel: SellerDetailViewModel(db: Firestore.firestore()))
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func didLogout() {
        parentCoordinator?.childDidFinish(self)
    }
}
