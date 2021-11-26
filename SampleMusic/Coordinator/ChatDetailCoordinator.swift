//
//  ChatDetailCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class ChatDetailCoordinator : Coordinator {
    
    var view : ChatDetailProtocol
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator : MainCoordinator?
    
    init(navigationController: UINavigationController,view: ChatDetailProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }
    
    
    
    
}
