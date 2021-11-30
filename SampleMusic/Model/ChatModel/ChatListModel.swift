//
//  ChatListModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class ChatListModel {
    var imageUser : String?
    var message : String?
    var recieverUid : String?
    var senderUid : String?
    
    init(data: [String:Any]) {
        self.imageUser = data["imageUser"] as? String
        self.message = data["message"] as? String
        self.recieverUid = data["recieverUid"] as? String
        self.senderUid = data["senderUid"] as? String
    }
}
