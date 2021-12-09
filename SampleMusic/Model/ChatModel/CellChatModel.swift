//
//  CellChatModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class CellChatModel {
    var image : String
    var chatRoom : String
    var senderUid : String
    var recieverUid : String
    var message : String
    
    init(image: String, chatRoom : String, senderUid: String, recieverUid: String, message: String) {
        self.image = image
        self.chatRoom = chatRoom
        self.recieverUid = recieverUid
        self.senderUid = senderUid
        self.message = message
    }
}
