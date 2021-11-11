//
//  TabBarCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 4.11.21.
//

import UIKit
import Dip


class TabBarCoordinator : Coordinator,TabBarScreenProtocol {
    var view: TabBarController
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.view = TabBarController(viewModel: try! appContainer.resolve(), sellerController: try! appContainer.resolve() , listController: try! appContainer.resolve())
    }
    
    func start() {
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func logout() {
//        navigationController.popViewController(animated: <#T##Bool#>)
        parentCoordinator?.childDidFinish(self)
    }
    
    func finish() {
        parentCoordinator?.childDidFinish(self)
    }
}
