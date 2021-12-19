//
//  StartViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 12.11.21.
//

import UIKit


class StartViewDraw : UIView {
    
    //MARK: - LogoView
    
    var logo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Icons.logoApp.rawValue)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - ButtonView
    
    var signUpButton: UIButton = {
        let button = UIButton()
        let buttonTitle = NSLocalizedString("SIGN_UP", comment: "")
        button.coraleButton(title: buttonTitle)
        return button
    }()
    
    var signInButton: UIButton = {
        let button = UIButton()
        let buttonTitle = NSLocalizedString("SIGN_IN", comment: "")
        button.coraleButton(title: buttonTitle)
        return button
    }()
    
    
    //MARK: - Constraints
    func viewCompare(view: UIView) {
        view.addSubview(logo)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)

        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.heightAnchor.constraint(equalToConstant: 250),
        ])
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: logo.bottomAnchor,constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            signInButton.heightAnchor.constraint(equalToConstant: 50)

        ])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor,constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            signUpButton.heightAnchor.constraint(equalTo: signInButton.heightAnchor)
        ])

    }
    
}
