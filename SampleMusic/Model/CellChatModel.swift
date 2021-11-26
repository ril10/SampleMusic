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
    
    init(image: UIImage, message : String) {
        self.image = image
        self.message = message
    }
}
