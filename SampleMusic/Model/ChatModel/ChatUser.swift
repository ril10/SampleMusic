//
//  ChatUser.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 30.11.21.
//

import Foundation
import RealmSwift
import UIKit

class ChatUser : Object {
   @Persisted var senderImage : Data?
   @Persisted var recieverImage : Data?
   @Persisted var recieverUid : String?
   @Persisted var ownerUid : String?
    
    convenience init(senderImage: Data, recieverImage: Data,recieverUid: String, ownerUid: String) {
        self.init()
        self.senderImage = senderImage
        self.recieverImage = recieverImage
        self.recieverUid = recieverUid
        self.ownerUid = ownerUid
    }
}
