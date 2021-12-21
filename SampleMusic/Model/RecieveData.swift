//
//  NotificationRecieveData.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 21.12.21.
//

import Foundation


struct RecieveData {
    let recieverUid : Any?
    let roomUid : Any?
    let ownerUid : Any?
    
    init(data : [AnyHashable: Any]) {
        self.recieverUid = data["recieverUid"]
        self.roomUid = data["roomUid"]
        self.ownerUid = data["ownerUid"]
    }
    
    enum CodingKeys : String, CodingKey {
        case recieverUid
        case roomUid
        case ownerUid
    }
}
