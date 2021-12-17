//
//  Purchased.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 17.12.21.
//

import Foundation


struct Purchased {
    var purchasedUid: String?
    var imageUrl: String?
    var sampleName: String?
    var sampleUrl: String?
    var duration: Int?
    
    init(data: [String:Any]) {
        self.purchasedUid = data["purchasedUid"] as? String
        self.imageUrl = data["imageUrl"] as? String
        self.sampleName = data["sampleName"] as? String
        self.sampleUrl = data["sampleUrl"] as? String
        self.duration = data["duration"] as? Int
    }
    
    enum CodingKeys: String, CodingKey {
        case purchasedUid
        case imageUrl
        case sampleName
        case sampleUrl
        case duration
    }
}
