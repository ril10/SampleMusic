//
//  Coordinator.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators : [Coordinator] { get }
    var navigationController: UINavigationController { get set }
    func start()
}
