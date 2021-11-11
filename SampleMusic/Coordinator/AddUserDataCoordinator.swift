//
//  AddUserDataCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import UIKit
import Dip


class AddUserDataCoordinator : Coordinator {
    var view: AddingDataViewController
    
    
    weak var parentCoordinator : MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var docId : String!
    var roleSet : String!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.view = AddingDataViewController(viewModel: try! appContainer.resolve())
    }
    
    func start() {
        
        view.viewModel?.docId = self.docId
        view.viewModel?.roleSet = self.roleSet
        view.coordinator = parentCoordinator
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(view, animated: true)
    }

}
