//
//  EnumSample.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 28.10.21.
//

import Foundation

enum Style : String, CaseIterable {
    case fontTitleLight = "Avenir Light"
    case fontTitleHeavy = "Avenir Heavy"
    case coralColor = "mainScreenRed"
    case textColor = "textColor"
    case backgroundColor = "backgroundColor"
    case appName = "Music Sample"
}

enum Gender : String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case undf = "Undefined"
    case chooseGender = "Choose youre gender*"
}

enum Collection : String, CaseIterable {
    case user
    case seller
    case sample
    case message
    case chatRoom
    
    func getCollection() -> String {
        switch self {
        case .seller:
            return "seller"
        case .user:
            return "user"
        case .message:
            return "message"
        case .sample:
            return "sample"
        case .chatRoom:
            return "chatRoom"
        }
    }
}

enum Icons : String, CaseIterable {
    case photo = "photo"
    case logoApp = "cloud.fill"
    case radioOn = "smallcircle.fill.circle"
    case radioOff = "circle.fill"
    case plusSquare = "plus.square"
    case play = "play"
    case pause = "pause"
    case mic = "mic.badge.plus"
    case add = "plus"
    case sort = "arrow.up.arrow.down"
    case check = "checkmark"
    case house = "house"
    case star = "star.fill"
    case message = "message"
    case person = "person.circle"
    case send = "paperplane"
    case eye = "eye"
    case crossEye = "eye.slash"
}

enum TableCell : String, CaseIterable {
    case cell = "CustomTableViewCell"
    case chatCell = "ChatCell"
    case chatDetailCell = "ChatDetailCell"
}

