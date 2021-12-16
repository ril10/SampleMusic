//
//  StoreModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 16.12.21.
//

import Foundation

struct StoreModel {
    var name: String
    var cost: Int
    var image: String
    
    init(data: [String:Any]) {
        self.name = data["name"] as! String
        self.cost = data["cost"] as! Int
        self.image = data["image"] as! String
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case cost
        case image
    }
}
