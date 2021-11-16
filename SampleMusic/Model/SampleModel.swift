//
//  SampleModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.10.21.
//

import UIKit


struct SampleModel: Codable {
    var sampleImageUrl : String
    var sampleName : String
    var sampleUrl : String
    
    init(data: [String:Any]) {
        self.sampleName = data["sampleName"] as! String
        self.sampleImageUrl = data["sampleImageUrl"] as! String
        self.sampleUrl = data["sampleUrl"] as! String
    }
    
    enum CodingKeys: String, CodingKey {
        case sampleImageUrl
        case sampleName
        case sampleUrl
    }
}
