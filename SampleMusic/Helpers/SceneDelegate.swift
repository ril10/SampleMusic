//
//  SceneDelegate.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import Firebase
import Dip

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    let container = DependencyContainer.configure()
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        func resolveType(type: Any.Type) -> Any? {
            return try? container.resolve(type)
        }
        
        FirebaseApp.configure()
        let navController = try! appContainer.resolve() as UINavigationController

        let coordinator = MainCoordinator(navigationController: navController,
                                          mainView: try! signContainer.resolve(),
                                          registrationView: try! signContainer.resolve(),
                                          listView: try! userContainer.resolve(),
                                          tabBar: try! userContainer.resolve(),
                                          addingView: try! signContainer.resolve(),
                                          startView: try! appContainer.resolve(),
                                          uploadView: try! userContainer.resolve(),
                                          userDetailView: try! userContainer.resolve(),
                                          recordPageView: try! userContainer.resolve()
        )
        coordinator.start()
//        coordinator.recordPage()



        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

