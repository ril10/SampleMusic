//
//  PushNotificationSender.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 13.12.21.
//

import UIKit
import FirebaseMessaging
import UserNotifications
import Firebase

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    let userUid: String
    
    init(userUid: String) {
        self.userUid = userUid
        super.init()
    }
    
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
//        updateFirestorePushTokenIfNeededForSeller()
        updateFirestorePushTokenIfNeededForUser()
    }
//    func updateFirestorePushTokenIfNeededForSeller() {
//        if let token = Messaging.messaging().fcmToken {
//            let sellerRef = Firestore.firestore().collection(Role.seller.rawValue.lowercased()).document(userUid)
//            sellerRef.setData(["fcmToken": token], merge: true)
//        }
//    }
    
    func updateFirestorePushTokenIfNeededForUser() {
        if let token = Messaging.messaging().fcmToken {
            let usersRef = Firestore.firestore().collection(Role.user.rawValue.lowercased()).document(userUid)
            usersRef.setData(["fcmToken": token], merge: true)
        }
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        updateFirestorePushTokenIfNeededForSeller()
        updateFirestorePushTokenIfNeededForUser()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
    
}
