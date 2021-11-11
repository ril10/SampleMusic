//
//  ListSamplesCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 4.11.21.
//

import UIKit
import FirebaseFirestore
import Dip

class ListSamplesCoordinator : Coordinator {
    var view: ListSamplesViewController
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.view = ListSamplesViewController(viewModel: try! appContainer.resolve())
    }
    
    func start() {
        view.coordinator = parentCoordinator
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func finish() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
