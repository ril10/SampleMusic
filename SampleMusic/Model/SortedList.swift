//
//  SortedList.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 6.12.21.
//

import Foundation
import RealmSwift

class SortedList: Object {
    @Persisted var orderIndex : Int32?
    @Persisted var ownerUid : String?
    
    convenience init(ownerUid: String, orderIndex: Int32) {
        self.init()
        self.ownerUid = ownerUid
        self.orderIndex = orderIndex
    }
}
