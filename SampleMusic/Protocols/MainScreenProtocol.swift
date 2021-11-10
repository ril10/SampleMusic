//
//  MainScreenProtocol.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 10.11.21.
//

import Foundation


protocol MainScreenProtocol {
    var view : MainScreenViewController! { get set }
    var coordinator : MainCoordinator? { get set }
    
}
