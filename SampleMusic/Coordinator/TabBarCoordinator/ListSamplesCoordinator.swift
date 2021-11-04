//
//  ListSamplesCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 4.11.21.
//

import UIKit

class ListSamplesCoordinator : Coordinator {
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ListSamplesViewController(viewModel: ListSampleViewModel())
        vc.coordinator = parentCoordinator
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func didLogout() {
        parentCoordinator?.childDidFinish(self)
    }
    
    deinit {
        print("List sample is dead")
    }
    
}
