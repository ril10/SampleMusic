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
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case description
        case email
        case gender
        case imageUrl
    }
}
