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
    var message : String
    var senderUid : String
    var recieverUid : String
    
    init(image: UIImage, message : String, senderUid: String, recieverUid: String) {
        self.image = image
        self.message = message
        self.recieverUid = recieverUid
        self.senderUid = senderUid
        
    }
}
