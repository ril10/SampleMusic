//
//  MainCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainScreenViewController(viewModel: MainScreenViewModel(db: Firestore.firestore()))
        vc.coordinator = self
        navigationController.delegate = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
        
    }
    
    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func registrationViewController() {
        let vc = RegistrationViewController(viewModel: RegistrationViewModel(db: Firestore.firestore()))
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func sellerDetailViewController() {
        let child = SellerCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
        child.parentCoordinator = self
//        let vc = SellerDetailViewController(viewModel: SellerDetailViewModel(db: Firestore.firestore()))
//        vc.coordinator = self
////        let vc1 = UINavigationController(rootViewController: SellerDetailViewController(viewModel: SellerDetailViewModel(db: Firestore.firestore())))
////        let vc2 = UINavigationController(rootViewController: ListSamplesViewController(viewModel: ListSampleViewModel()))
////        let tabBarController = UITabBarController()
////        tabBarController.setViewControllers([vc1,vc2], animated: false)
////        guard let items = tabBarController.tabBar.items else { return }
////        let images = ["house","star"]
////        for x in 0..<items.count {
////            items[x].image = UIImage(systemName: images[x])
////        }
//        self.navigationController.setNavigationBarHidden(false, animated: false)
//        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func listSamplesViewController() {
        let vc = ListSamplesViewController(viewModel: ListSampleViewModel())
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func addUserData(role: String,docId: String) {
        let vc = AddingDataViewController(viewModel: AddingDataAboutUserViewModel(db: Firestore.firestore(), st: Storage.storage()))
        vc.viewModel.roleSet = role
        vc.viewModel.docId = docId
        vc.coordinator = self
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let sellerDetail = fromViewController as? SellerDetailViewController {
            childDidFinish(sellerDetail.coordinator)
        }
    }
    
}
