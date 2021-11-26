//
//  MainScreenProtocol.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 10.11.21.
//

import Foundation
import UIKit
import AudioToolbox


protocol MainScreenProtocol: MainScreenViewController { }

protocol RegistrationScreenProtocol: RegistrationViewController { }

protocol ListSamplesScreenProtocol: ListSamplesViewController { }

protocol SellerScreenProtocol: SellerDetailViewController { }

protocol AddingDataScreenProtocol: AddingDataViewController { }

protocol TabBarScreenProtocol: TabBarController { }

protocol StartViewProtocol: StartViewController { }

protocol UploadMusicProtocol: UploadMusicViewController { }

protocol MusicPlayerProtocol : MusicPlayer { }

protocol UserDetailProtocol : UserDetailViewController { }

protocol RecordPageProtocol : RecordPageViewController { }

protocol ChatPageProtocol : ChatPageViewController { }

protocol ChatDetailProtocol : ChatDetailViewController { }

