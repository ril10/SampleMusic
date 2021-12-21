//
//  AppDelegate.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import Firebase
import FirebaseMessaging
import FirebaseAuth
import UserNotifications
import Dip


@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        Messaging.messaging().delegate = self

        return true
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo

    completionHandler([[.alert, .sound]])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo


    completionHandler()
  }
    func application(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        let notData = RecieveData(data: userInfo)
        let recUid = notData.recieverUid as! String
        let ownerUid = notData.ownerUid as! String
        let roomUid = notData.roomUid as! String
        
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
                                          recordPageView: try! userContainer.resolve(),
                                          chatPageView: try! userContainer.resolve(),
                                          chatDetailView: try! userContainer.resolve(),
                                          sellerDetailView: try! userContainer.resolve(),
                                          storeCurrencyView: try! appContainer.resolve()
        )
        
        coordinator.chatDetail(ownerUid: ownerUid, chatRoom: roomUid, recieverUid: recUid)

      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken;
    }
}

