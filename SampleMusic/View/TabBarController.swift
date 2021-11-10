//
//  TabBarController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import UIKit
import Dip


class TabBarController: UITabBarController {
    var coordinator: TabBarCoordinator?
    var container: DependencyContainer!
    var sellerController : SellerDetailViewController!
    var listController : ListSamplesViewController!
    var viewModel : TabBarImp!
    
    init() {
        self.container = appContainer
//        self.coordinator = try! container.resolve() as MainCoordinatorImp
        self.sellerController = try! container.resolve() as SellerDetailViewController
        self.listController = try! container.resolve() as ListSamplesViewController
        self.viewModel = try! container.resolve() as TabBarImp
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            createNavController(for: sellerController, title: "Seller Detail", image: UIImage(systemName: "house")!),
            createNavController(for: listController, title: "Samples", image: UIImage(systemName: "star.fill")!)
        ]
        self.coordinator?.childCoordinators = []
        viewModel?.reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.view.setNeedsDisplay()
            }
        }
    }
    
    private func createNavController(for rootViewController: UIViewController,title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
        rootViewController.navigationItem.title = title
        rootViewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        rootViewController.navigationController?.navigationBar.shadowImage = UIImage()
        rootViewController.navigationController?.navigationBar.layoutIfNeeded()
        rootViewController.navigationController?.navigationBar.barTintColor = .white
        rootViewController.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.colorButton.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutAction(sender:)))
        rootViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editData(sender:)))
        return navController
    }

    @objc func logoutAction(sender: UIButton) {
        viewModel.logout()
        coordinator?.logout()
        coordinator?.parentCoordinator?.logout()
    }
    
    @objc func editData(sender: UIButton) {
        
    }
    
}
