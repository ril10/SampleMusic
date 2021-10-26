//
//  Configure.swift
//  SampleMusic
//
//  Created by administrator on 26.10.21.
//

import Foundation
import Dip

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            unowned let container = container
            container.register(tag: "MainScreen") { MainScreenViewModel() }
            
            container.register(.unique) { MainScreenViewController() }
                .resolvingProperties { container, service in
                    service.viewModel = try container.resolve(tag: "MainScreen")
                }
            
            DependencyContainer.uiContainers = [container]
        }
    }
}
