//
//  StoreCurrencyCoordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 16.12.21.
//

import UIKit
import Foundation


class StoreCurrencyCoordinator : Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator : MainCoordinator?
    var navigationController: UINavigationController
    var view: StoreCurrencyProtocol
    
    init(navigationController: UINavigationController, view: StoreCurrencyProtocol) {
        self.navigationController = navigationController
        self.view = view
    }
    
    func start() {
        view.coordinator = self
        self.navigationController.pushViewController(view, animated: true)
    }
    
    
}
