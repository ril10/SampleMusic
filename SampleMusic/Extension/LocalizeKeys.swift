//
//  LocalizeKeys.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.12.21.
//

import Foundation

enum MainKeys : String, CaseIterable {
    case signIn = "SIGN_IN"
    case signUp = "SIGN_UP"
    case email = "EMAIL"
    case enterLogin = "ENTERLOGIN"
    case welcome = "WELCOME"
    case password = "PASSWORD"
    case typePass = "ENTERPASSW"
    case loading = "LOADING"
    case wait = "PLEASE_WAIT"
    case logout = "LOGOUT"
    case search = "SEARCH"
    case edit = "EDIT"
    case listSamples = "LIST_SAMPLES"
    case ok = "OK"
}

enum StoreKey : String, CaseIterable {
    case storeTitle = "STORE_TITLE"
    case tapBuy = "TAP_BUY"
}

enum SignUpKeys : String, CaseIterable {
    case choseRole = "CHOSEROLE"
    case user = "USER"
    case seller = "SELLER"
    case contin = "CONTINUE"
    case haveAcc = "HAVE_ACC"
    case forgetPassw = "FORGET_PASSW"
}

enum AddDataKeys : String, CaseIterable {
    case firstName = "FIRST_NAME"
    case lastName = "LAST_NAME"
    case yourSelf = "YOUR_SELF"
    case choseGender = "CHOOSE_GENDER"
    case male = "MALE"
    case female = "FEMALE"
    case undef = "UNDEFINED"
    case add = "ADD"
}

enum SamplesKeys : String, CaseIterable {
    case samples = "SAMPLES"
    case bName = "B_NAME"
    case bLength = "LENGTH"
    case free = "FREE"
    case paid = "PAID"
    case bPrice = "B_PRICE"
}

enum DetailKeys : String, CaseIterable {
    case fName = "F_NAME"
    case lName = "L_NAME"
    case descr = "DESCRIPTION"
    case gend = "GENDER"
    case uDetail = "USER_DETAIL"
    case sDetail = "SELLER_DETAIL"
    case email = "EMAIL_DETAIL"
}

enum ChatKeys : String, CaseIterable {
    case chatList = "CHAT_LIST"
    case writeMess = "WRITE_MSSG"
    case sendMess = "SEND_MESS"
    case chatDetail = "CHAT_DETAIL"
}

enum UploadKeys : String, CaseIterable {
    case uplImg = "UPLOAD_IMAGE"
    case sampleName = "SAMPLE_NAME"
    case typeName = "TYPE_NAME"
    case chooseSample = "CHOOSE_SAMPLE"
    case typeSample = "TYPE_SAMPLE"
    case costValue = "COST_VALUE"
}

enum RecordKeys : String, CaseIterable {
    case recordName = "RECORD_NAME"
    case recordSample = "RECORD_SAMPLE"
    case record = "RECORDING"
}

enum ErrorKeys : String, CaseIterable {
    case eSignIn = "E_SIGN_IN"
    case eSignUp = "E_SIGN_UP"
    case eRole = "E_ROLE"
    case eData = "E_ADD_DATA"
    case eField = "E_FIELDS"
}
