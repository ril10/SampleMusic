//
//  RegistrationControllerImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.11.21.
//

import Foundation

protocol RegistrationControllerImp {
    var reloadView : (() -> Void)? { get set }
    var error : ((Error) -> Void)? { get set }
    var roleSet : String! { get set }
    var docId : String! { get set }
    var navToAdd : ((Bool) -> Void)? { get set }
    var isRole : Bool! { get set }
    var loading : ((Bool) -> Void)? { get set }
    func registerUser(email: String, password: String)
    func roleChoose(_ role: String)
}
