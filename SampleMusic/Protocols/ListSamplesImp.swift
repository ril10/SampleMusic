//
//  ListSamplesImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.11.21.
//

import Foundation

protocol ListSamplesImp {
    var reloadTableView : (() -> Void)? { get set }
    func logout()
}
