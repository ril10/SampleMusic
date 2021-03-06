//
//  SampleModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.10.21.
//

import UIKit


struct SampleModel: Codable {
    var sampleImageUrl : String?
    var sampleName : String?
    var sampleUrl : String?
    var ownerUid : String?
    var duration : Int?
    var index : Int?
    var cost : Int?
    var id : String?
    
    init(data: [String:Any]) {
        self.sampleName = data["sampleName"] as? String
        self.sampleImageUrl = data["sampleImageUrl"] as? String
        self.sampleUrl = data["sampleUrl"] as? String
        self.ownerUid = data["ownerUid"] as? String
        self.duration = data["duration"] as? Int
        self.index = data["index"] as? Int
        self.cost = data["cost"] as? Int
        self.id = data["id"] as? String
    }
    
    enum CodingKeys: String, CodingKey {
        case sampleImageUrl
        case sampleName
        case sampleUrl
        case ownerUid
        case duration
        case index
        case id
    }
}
