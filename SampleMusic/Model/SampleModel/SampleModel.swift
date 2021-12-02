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
    
    init(data: [String:Any]) {
        self.sampleName = data["sampleName"] as? String
        self.sampleImageUrl = data["sampleImageUrl"] as? String
        self.sampleUrl = data["sampleUrl"] as? String
        self.ownerUid = data["ownerUid"] as? String
        self.duration = data["duration"] as? Int
    }
    
    enum CodingKeys: String, CodingKey {
        case sampleImageUrl
        case sampleName
        case sampleUrl
        case ownerUid
        case duration
    }
}
