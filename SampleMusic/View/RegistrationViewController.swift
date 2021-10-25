//
//  RegistrationViewController.swift
//  SampleMusic
//
//  Created by administrator on 25.10.21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var coordinator : MainCoordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigator()
    }
    
    func configNavigator() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGray,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        nav?.isTranslucent = true
        nav?.backItem?.title = "Back"
        nav?.topItem?.title = "Main"
        nav?.tintColor = .darkGray

    }
    
}
