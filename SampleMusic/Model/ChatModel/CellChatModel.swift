//
//  CellChatModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import Foundation
import UIKit


class CellChatModel {
    var image : UIImage
    var chatRoom : String
    var senderUid : String
    var recieverUid : String
    
    init(image: UIImage, chatRoom : String, senderUid: String, recieverUid: String) {
        self.image = image
        self.chatRoom = chatRoom
        self.recieverUid = recieverUid
        self.senderUid = senderUid
    }
}
