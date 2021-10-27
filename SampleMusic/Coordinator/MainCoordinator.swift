//
//  MainCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import FirebaseFirestore

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
        let vc = RegistrationViewController(viewModel: RegistrationViewModel(db: Firestore.firestore()))
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func sellerDetailViewController() {
        let vc = SellerDetailViewController()
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func listSamplesViewController() {
        let vc = ListSamplesViewController()
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func addUserData() {
        let vc = AddingDataViewController()
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    
}
