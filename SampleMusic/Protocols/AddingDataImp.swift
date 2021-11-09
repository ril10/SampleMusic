//
//  AddingDataimp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.11.21.
//

import Foundation

protocol AddingDataImp {
    var roleSet : String! { get set }
    var gender : String! { get set }
    var reloadView : (() -> Void)? { get set }
    var docId : String! { get set }
    var navSeller : ((Bool) -> Void)? { get set }
    var navUser : ((Bool) -> Void)? { get set }
    var loading : ((Bool) -> Void)? { get set }
    func currentUser(firstName: String,lastName: String,description: String)
    func uploadImage(image: Data)
    func genderSet(gender: String)
}
