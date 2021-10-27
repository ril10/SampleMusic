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
        let vc = MainScreenViewController(viewModel: MainScreenViewModel())
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func registrationViewController() {
        let vc = RegistrationViewController(viewModel: RegistrationViewModel())
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    
}
