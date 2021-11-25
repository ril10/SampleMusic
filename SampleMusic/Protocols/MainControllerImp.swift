//
//  MainControllerImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.11.21.
//

import Foundation


protocol MainControllerImp {
    func userSignIn(email: String,password: String)
    var loading : ((Bool) -> Void)? { set get }
    var dismisAlert : ((Bool) -> Void)? { set get }
    var reloadView : (() -> Void)? { set get }
    var loadCompleteUser : ((Bool) -> Void)? { set get }
    var loadCompleteSeller : ((Bool) -> Void)? { set get }
    var error : ((Error) -> Void)? { set get }
    func userSign()
    func sellerSign()
}
