//
//  ListSamplesViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import UIKit


class ListSamplesViewController: UIViewController {
    
    var coordinator : MainCoordinator?
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Samples"
        
    }
}
