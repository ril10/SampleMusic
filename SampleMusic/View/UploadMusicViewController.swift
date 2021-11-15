//
//  UploadMusic.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 15.11.21.
//

import UIKit

class UploadMusicViewController : UIViewController {
    
    var drawView = UploadMusicDraw()
    var coordinator : MainCoordinator?
    //MARK: - View
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension UploadMusicViewController : UploadMusicProtocol { }
