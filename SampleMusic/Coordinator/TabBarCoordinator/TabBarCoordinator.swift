//
//  TabBarCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 4.11.21.
//

import UIKit
import Dip


class TabBarCoordinator : Coordinator {
    var view: TabBarScreenProtocol
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,view: TabBarScreenProtocol) {
        self.navigationController = navigationController
        self.view = view//TabBarController(viewModel: try! appContainer.resolve(), sellerController: try! appContainer.resolve() as SellerScreenProtocol , listController: try! appContainer.resolve() as ListSamplesScreenProtocol ) as TabBarScreenProtocol
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
