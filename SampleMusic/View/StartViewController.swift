//
//  StartViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 12.11.21.
//

import UIKit


class StartViewController: UIViewController {
    
    var drawView = StartViewDraw()
    var coordinator : MainCoordinator?
    
    
    //MARK: - ActionButton
    @objc func signUpButton(sender: UIButton!) {
        coordinator?.finish()
        coordinator?.registrationViewController()
    }
    
    @objc func signInButton(sender: UIButton!) {
        coordinator?.finish()
        coordinator?.mainScreenView()
    }
    
    //MARK: - View
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        
        drawView.viewCompare(view: view)
        drawView.signUpButton.addTarget(self, action: #selector(signUpButton(sender:)), for: .touchUpInside)
        drawView.signInButton.addTarget(self, action: #selector(signInButton(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

extension StartViewController: StartViewProtocol {}
