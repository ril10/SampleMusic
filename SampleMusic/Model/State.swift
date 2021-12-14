//
//  StateModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.11.21.
//

import Foundation
import RealmSwift

class State: Object {
    @Persisted var state : String?
    @Persisted var role : String?
    
    convenience init(state: String,role: String) {
        self.init()
        self.state = state
        self.role = role
    }
}
