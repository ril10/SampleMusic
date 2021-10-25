//
//  MainCoordinator.swift
//  SampleMusic
//
//  Created by administrator on 25.10.21.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainScreenViewController = MainScreenViewController()
        navigationController.pushViewController(mainScreenViewController, animated: true)
    }
    
    
    
    
}
