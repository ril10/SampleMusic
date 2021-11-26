//
//  ChatPageCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class ChatPageCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator : MainCoordinator?
    var navigationController: UINavigationController
    var view : ChatPageProtocol
    
    init(navigationController: UINavigationController,view: ChatPageProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }
    
    
    
}
