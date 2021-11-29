//
//  MessageDataModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.11.21.
//

import Foundation


struct MessageDataModel: Codable {
    var message : String?
    var senderUid : String?
    var data : Double?
    
    init(data: [String:Any]) {
        self.message = data["message"] as? String
        self.senderUid = data["senderUid"] as? String
        self.data = data["data"] as? Double
    }
    
    enum CodingKeys: String, CodingKey {
        case message
        case senderUid
        case data
    }
    
}
