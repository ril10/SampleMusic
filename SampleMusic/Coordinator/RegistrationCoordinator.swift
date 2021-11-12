//
//  RegistrationCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import UIKit
import Dip

class RegistrationCoordinator : Coordinator {
    var view: RegistrationScreenProtocol
    
    
    weak var parentCoordinator : MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,view: RegistrationScreenProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }

    func finish() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
        
    }
    
}
