//
//  RecordPageCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 22.11.21.
//

import Foundation
import UIKit


class RecordPageCoordinator : Coordinator {
    var view : RecordPageProtocol
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator : MainCoordinator?
    var navigationController: UINavigationController
    init(navigationController: UINavigationController,view: RecordPageProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    
    func start() {
        view.coordinator = self
        self.navigationController.present(view, animated: true, completion: nil)
    }
    
    func finish() {
        navigationController.dismiss(animated: true)
        parentCoordinator?.childDidFinish(self)
    }
}
