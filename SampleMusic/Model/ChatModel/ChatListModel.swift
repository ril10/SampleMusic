//
//  ChatListModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class ChatListModel {
    var chatRoom : String?
    var recieverUid : String?
    var senderUid : String?
    var lastMessage : String?
    
    init(data: [String:Any]) {
        self.chatRoom = data["chatRoom"] as? String
        self.recieverUid = data["recieverUid"] as? String
        self.senderUid = data["ownerUid"] as? String
        self.lastMessage = data["lastMessage"] as? String
    }
}
