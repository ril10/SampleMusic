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
    case logoApp = "cloud.fill"
    case radioOn = "smallcircle.fill.circle"
    case radioOff = "smallcircle.circle"
    case appName = "Music Sample"
    case plusSquare = "plus.square"
    case photo = "photo"
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
    case chooseRole = "Choose your role*"
}

enum Titles : String, CaseIterable {
    case signIn = "Sign In"
    case email = "Email"
    case password = "Password"
    case signUp = "Sign Up"
    case forgetPassword = "Forget Password?"
    case ok = "Ok"
    case welcome = "Welome there"
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
}

enum AlertTitle : String, CaseIterable {
    case errorSignIn = "Error Sign In"
    case errorSignUp = "Error Sign Up"
    case selectRole = "Select your role"
    case errorAddingData = "Error Adding data"
}


