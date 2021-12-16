//
//  RoleModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.10.21.
//

import Foundation

struct DetailModel: Codable {
    let firstName : String
    let lastName : String
    let description : String
    let email : String
    let gender : String
    let imageUrl : String
    let balance : Int?
    
    init(data: [String: Any]) {
        self.firstName = data["firstName"] as! String
        self.lastName = data["lastName"] as! String
        self.description = data["description"] as! String
        self.email = data["email"] as! String
        self.gender = data["gender"] as! String
        self.imageUrl = data["imageUrl"] as! String
        self.balance = data["balance"] as? Int
    }
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case description
        case email
        case gender
        case imageUrl
        case balance
    }
}
