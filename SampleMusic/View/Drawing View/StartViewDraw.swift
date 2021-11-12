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
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 70, weight: .bold, scale: .large)
        image.image = UIImage(systemName: Icons.logoApp.rawValue,withConfiguration: largeConfig)
        image.tintColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - ButtonView
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.coraleButton(title: Titles.signUp.rawValue)
        return button
    }()
    
    var signInButton: UIButton = {
        let button = UIButton()
        button.coraleButton(title: Titles.signIn.rawValue)
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
