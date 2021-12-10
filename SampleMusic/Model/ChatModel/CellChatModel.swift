//
//  CellChatModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class CellChatModel {
    var chatRoom : String
    var ownerUid : String
    var recieverUid : String
    var message : String
    
    init(chatRoom : String, ownerUid: String, recieverUid: String, message: String) {
        self.chatRoom = chatRoom
        self.recieverUid = recieverUid
        self.ownerUid = ownerUid
        self.message = message
    }
}
