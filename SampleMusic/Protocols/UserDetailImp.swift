//
//  UserDetailProtocol.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 22.11.21.
//

import Foundation


protocol UserDetailViewModelImp {
    var reloadView : (() -> Void)? { get set }
    var fieldData : ((String,String,String,String,String,String) -> Void)? { get set }
    func userData()
    var dismissAlert : ((Bool) -> Void)? { get set }
    var balanceStatus : ((String) -> Void)? { get set }
    var reloadTableView : (() -> Void)? { get set }
}
