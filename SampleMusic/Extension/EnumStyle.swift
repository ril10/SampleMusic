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
    case colorButton = "mainScreenRed"
    case appName = "Music Sample"
}

enum Gender : String, CaseIterable {
    case male = "Male"
    case female = "Female"
    case undf = "Undefined"
    case chooseGender = "Choose youre gender*"
}

enum Role : String, CaseIterable {
    case user = "User"
    case seller = "Seller"
    case sample = "Sample"
    case chooseRole = "Choose your role*"
}

enum Titles : String, CaseIterable {
    case signIn = "Sign In"
    case email = "Email"
    case password = "Password"
    case signUp = "Sign Up"
    case forgetPassword = "Forget Password?"
    case ok = "Ok"
    case welcome = "Welome!"
    case contin = "Continue"
    case haveAcc = "Have an Account?"
    case add = "Add"
}

enum TextFieldLabel : String, CaseIterable {
    case enterLog = "Enter your login"
    case enterEmail = "Enter your email"
    case enterPassword = "Enter your password"
    case enterFirstName = "Enter your First Name"
    case enterLastName = "Enter your Last Name"
    case aboutSelf = "Type about your self"
    case allFields = "Fill all fields"
    case sampleName = "Type sample name"
}

enum AlertTitle : String, CaseIterable {
    case errorSignIn = "Error Sign In"
    case errorSignUp = "Error Sign Up"
    case selectRole = "Select your role"
    case errorAddingData = "Error Adding data"
    case loading = "Loading"
    case wait = "Please wait..."
}

enum TitleDetail : String, CaseIterable {
    case firstName = "First Name:"
    case lastName = "Last Name:"
    case gender = "Gender:"
    case description = "Description:"
    case email = "Email:"
    case samples = "List of Samples"
    case sampleName = "2.Type sample name:"
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
}

enum TableCell : String, CaseIterable {
    case cell = "CustomTableViewCell"
    case chatCell = "ChatCell"
    case chatDetailCell = "ChatDetailCell"
}

