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
        parentCoordinator?.childDidFinish(self)
        navigationController.isNavigationBarHidden = true
        self.navigationController.viewControllers.removeAll()
    }
    
    func goToStart() {
        parentCoordinator?.childDidFinish(self)
        self.navigationController.viewControllers.removeAll()
        parentCoordinator?.start()
    }
    
    func goToDetailPage() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.userDetail()
    }
    
    func goToSellerPage(ownerUid: String, chatRoom: String) {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.sellerDetail(ownerUid: ownerUid, chatRoom: chatRoom, recieverUid: "")
    }
    
}
