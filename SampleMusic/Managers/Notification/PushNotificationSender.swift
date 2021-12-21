//
//  PushNotificationSender.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 13.12.21.
//

import UIKit

class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String, recieverUid: String, ownerUid: String, roomUid: String) {
        let urlString = UIApplication.notificationUrl
        let url = URL(string: urlString!)
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body],
                                           "content_available" : true,
                                           "data" : ["recieverUid" : recieverUid,
                                                     "ownerUid":ownerUid,
                                                     "roomUid":roomUid]
        ]
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(String(describing: UIApplication.serverKey!))", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
