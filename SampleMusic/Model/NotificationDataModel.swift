//
//  NotificationDataModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 14.12.21.
//

import Foundation


struct NotificationDataModel {
    var firstName : String
    var imageUrl : String
    
    init(data: [String: Any]) {
        self.firstName = data["firstName"] as! String
        self.imageUrl = data["imageUrl"] as! String
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case imageUrl
    }
}
