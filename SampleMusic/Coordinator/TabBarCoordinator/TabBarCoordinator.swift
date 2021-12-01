//
//  TabBarCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 4.11.21.
//

import UIKit
import Dip


class TabBarCoordinator : Coordinator {
    var view: TabBarScreenProtocol
    
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,view: TabBarScreenProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }
    
    func finish() {
        navigationController.viewControllers.removeLast()
//        navigationController.popViewController(animated: true)
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.start()
    }
    
    func upload() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.uploadMusic()
    }

    func createSample() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.recordPage()
    }
    
    func goToChat(recieverUid: String) {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.chatPage(recieverUid: recieverUid)
    }
}
