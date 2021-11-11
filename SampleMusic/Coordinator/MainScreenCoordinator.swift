//
//  MainScreenCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 11.11.21.
//

import UIKit
import Dip

class MainScreenCoordinator : Coordinator {
    var view: MainScreenProtocol
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator : MainCoordinator?
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController,view: MainScreenProtocol) {
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
