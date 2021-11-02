//
//  MainCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController,tabBarController: UITabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        let vc = MainScreenViewController(viewModel: MainScreenViewModel(db: Firestore.firestore()), drawView: MainScreenDraw())
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func registrationViewController() {
        let vc = RegistrationViewController(viewModel: RegistrationViewModel(db: Firestore.firestore()), drawView: RegistrationViewDraw())
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func sellerDetailViewController() {
        let vc1 = UINavigationController(rootViewController: SellerDetailViewController())
        let vc2 = UINavigationController(rootViewController: ListSamplesViewController())
        self.tabBarController.setViewControllers([vc1,vc2], animated: false)
        guard let items = self.tabBarController.tabBar.items else { return }
        let images = ["house","star"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
        self.navigationController.pushViewController(self.tabBarController, animated: true)
    }
    
    func listSamplesViewController() {
        let vc = ListSamplesViewController()
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func addUserData(role: String,docId: String) {
        let vc = AddingDataViewController(viewModel: AddingDataAboutUserViewModel(db: Firestore.firestore(), st: Storage.storage()), drawView: AddingDataDraw())
        vc.viewModel.roleSet = role
        vc.viewModel.docId = docId
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    
    
}
