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
    
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//        if let sellerDetail = fromViewController as? SellerDetailViewController {
//            childDidFinish(sellerDetail.coordinator)
//        }
//    }
    
    func start() {
        let vc = MainScreenViewController(viewModel: MainScreenViewModel(db: Firestore.firestore()))
        vc.coordinator = self
//        navigationController.delegate = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func registrationViewController() {
        let vc = RegistrationViewController(viewModel: RegistrationViewModel(db: Firestore.firestore()))
        vc.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func sellerDetailViewController() {
        let child = SellerCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
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
//        navigationController.setNavigationBarHidden(false, animated: false)
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
        start()
    }
    
    func listSamplesViewController() {
        let vc = ListSamplesViewController(viewModel: ListSampleViewModel())
        vc.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func addUserData(role: String,docId: String) {
        let vc = AddingDataViewController(viewModel: AddingDataAboutUserViewModel(db: Firestore.firestore(), st: Storage.storage()))
        vc.viewModel.roleSet = role
        vc.viewModel.docId = docId
        vc.coordinator = self
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
