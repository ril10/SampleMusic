//
//  UserDetailCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 22.11.21.
//

import Foundation
import UIKit


class UserDetailCoordinator : Coordinator {
    var view : UserDetailProtocol
    var childCoordinators = [Coordinator]()
    
    weak var parentCoordinator : MainCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,view: UserDetailProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func navToChatList() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.chatPage(recieverUid: "")
    }
    
    
    
}
