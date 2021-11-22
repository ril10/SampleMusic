//
//  RecordPageViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import UIKit


class RecordPageViewController : UIViewController {
    
    var coordinator : RecordPageCoordinator?
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension RecordPageViewController : RecordPageProtocol {}
