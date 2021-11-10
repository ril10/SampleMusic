//
//  TabBarImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 9.11.21.
//

import Foundation


protocol TabBarImp {
    var reloadView : (() -> Void)? { get set }
    func logout()
}
