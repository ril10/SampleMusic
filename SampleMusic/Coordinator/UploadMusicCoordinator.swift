//
//  UploadMusicCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 15.11.21.
//

import Foundation
import UIKit


class UploadMusicCoordinator : Coordinator {
    
    var view : UploadMusicProtocol
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordiantor : MainCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController,view: UploadMusicProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.coordinator = parentCoordiantor
        self.navigationController.present(view, animated: true, completion: nil)
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
        parentCoordiantor?.childDidFinish(self)
    }
    
    
    
    
}
