//
//  ChatListModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class ChatListModel {
    var imageUser : String
    var message : String
    
    init(imageUser: String, message: String) {
        self.imageUser = imageUser
        self.message = message
    }
}
