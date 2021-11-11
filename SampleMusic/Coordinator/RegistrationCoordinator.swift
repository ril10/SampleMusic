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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.view = try! appContainer.resolve() as RegistrationScreenProtocol
    }
    
    func start() {
        
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }

    func finish() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
