//
//  SellerDetailCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class SellerDetailCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator : MainCoordinator?
    var navigationController: UINavigationController
    var view : SellerScreenProtocol
    
    var ownerUid : String?
    
    init(navigationController: UINavigationController, view: SellerScreenProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.coordinator = self
        view.viewModel.ownerUid = self.ownerUid!
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func writeMessage() {
        self.parentCoordinator?.childDidFinish(self)
        self.parentCoordinator?.chatDetail()
    }
    
    
}
