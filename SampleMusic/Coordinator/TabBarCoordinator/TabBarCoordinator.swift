//
//  TabBarCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 4.11.21.
//

import UIKit


class TabBarCoordinator : Coordinator {
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = UITabBarController()
        
        let sellerNav = UINavigationController()
        let sellCoordinator = SellerCoordinator(navigationController: sellerNav)
        sellCoordinator.parentCoordinator = self
        let sellerItem = UITabBarItem()
        sellerItem.title = "Seller Detail"
        sellerItem.image = UIImage(systemName: "house")
        sellerNav.tabBarItem = sellerItem
        
        
        let sampleNav = UINavigationController()
        let sampleCoordinator = ListSamplesCoordinator(navigationController: sampleNav)
        sampleCoordinator.parentCoordinator = parentCoordinator
        let sampleItem = UITabBarItem()
        sampleItem.title = "Samples"
        sampleItem.image = UIImage(systemName: "star.fill")
        sampleNav.tabBarItem = sampleItem
        
        vc.viewControllers = [sellerNav,sampleNav]
        navigationController.definesPresentationContext = true
        navigationController.pushViewController(vc, animated: true)
        navigationController.setNavigationBarHidden(true, animated: true)
        
        parentCoordinator?.childCoordinators.append(sellCoordinator)
        parentCoordinator?.childCoordinators.append(sampleCoordinator)
        
        sellCoordinator.start()
        sampleCoordinator.start()
        
    }
}
