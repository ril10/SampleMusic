//
//  MessageDataModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.11.21.
//

import Foundation


struct MessageDataModel: Codable {
    var message : String?
    var ownerUid : String?
    var sendDate : Double?
    var recieverUid : String?
    
    
    init(data: [String:Any]) {
        self.message = data["message"] as? String
        self.ownerUid = data["ownerUid"] as? String
        self.sendDate = data["sendDate"] as? Double
        self.recieverUid = data["recieverUid"] as? String
    }
    
    enum CodingKeys: String, CodingKey {
        case message
        case ownerUid
        case sendDate
        case recieverUid
    }
    
}
