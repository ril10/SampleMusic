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
    
    func goToChatDetail(ownerUid: String, chatRoom: String,recieverUid: String) {
        self.parentCoordinator?.childDidFinish(self)
        self.parentCoordinator?.chatDetail(ownerUid: ownerUid, chatRoom: chatRoom, recieverUid: recieverUid)
    }
    
    
}
