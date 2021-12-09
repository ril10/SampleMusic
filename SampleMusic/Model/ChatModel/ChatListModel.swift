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
    var ownerUid : String?
    
    init(data: [String:Any]) {
        self.chatRoom = data["chatRoom"] as? String
        self.recieverUid = data["recieverUid"] as? String
        self.ownerUid = data["ownerUid"] as? String
    }
}
