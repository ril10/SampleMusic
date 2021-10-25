//
//  Coordinator.swift
//  SampleMusic
//
//  Created by administrator on 25.10.21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
