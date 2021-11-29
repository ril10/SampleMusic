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
    var view: ListSamplesScreenProtocol
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController,view: ListSamplesScreenProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.coordinator = self
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
        navigationController.viewControllers.removeLast()
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.start()
    }
    
    func goToDetailPage() {
        navigationController.popViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.userDetail()
    }
    
    func goToSellerPage(ownerUid: String) {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.sellerDetail(ownerUid: ownerUid)
    }
    
}
