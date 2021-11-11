//
//  MainScreenProtocol.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 10.11.21.
//

import Foundation
import UIKit


protocol MainScreenProtocol: MainScreenViewController { }

protocol RegistrationScreenProtocol: RegistrationViewController { }

protocol ListSamplesScreenProtocol {
    var view : ListSamplesViewController { get set }
}

protocol SellerScreenProtocol {
    var view : SellerDetailViewController { get set }
}

protocol AddingDataScreenProtocol {
    var view : AddingDataViewController { get set }
}

protocol TabBarScreenProtocol {
    var view : TabBarController { get set }
}

