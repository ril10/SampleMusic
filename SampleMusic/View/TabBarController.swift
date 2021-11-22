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
    var sellerController : SellerDetailViewController!
    var listController : ListSamplesViewController!
    var viewModel : TabBarImp!
    
    init(viewModel: TabBarImp,sellerController: SellerDetailViewController,listController: ListSamplesViewController) {
        self.viewModel = viewModel
        self.sellerController = sellerController
        self.listController = listController
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
        sellerController.drawView.addButton.addTarget(self, action: #selector(upload(sender:)), for: .touchUpInside)
        sellerController.drawView.createSampleButton.addTarget(self, action: #selector(createSample(sender:)), for: .touchUpInside)
    }
    
    @objc func upload(sender: UIButton) {
        coordinator?.parentCoordinator?.uploadMusic()
    }
    
    @objc func createSample(sender: UIButton) {
        coordinator?.createSample()
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
        coordinator?.finish()        
    }
    
    @objc func editData(sender: UIButton) {
        
    }
    
}
extension TabBarController : TabBarScreenProtocol {}
