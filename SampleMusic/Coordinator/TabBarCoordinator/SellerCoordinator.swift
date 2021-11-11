//
//  SellerCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import Foundation
import UIKit
import FirebaseFirestore
import Dip


class SellerCoordinator: Coordinator {
    var view: SellerScreenProtocol
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,view: SellerScreenProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    
    func start() {
        view.coordinator = parentCoordinator
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func finish() {
        parentCoordinator?.childDidFinish(self)
    }
}
