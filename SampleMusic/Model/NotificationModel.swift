//
//  TokenModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 14.12.21.
//

import Foundation

struct NotificationModel {
    var fcmToken : String
    
    init(data: [String: Any]) {
        self.fcmToken = data["fcmToken"] as! String
    }
    
    enum CodingKeys: String, CodingKey {
        case fcmToken
    }
}
