//
//  SellerImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.11.21.
//

import Foundation

protocol SellerImp {
    var reloadView : (() -> Void)? { get set }
    var isLogout : ((Bool) -> Void)? { get set }
    var fieldData : ((String,String,String,String,String) -> Void)? { get set }
    func userData()
    func logout()
}
