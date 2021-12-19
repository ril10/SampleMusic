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
    
    //MARK: - Constraints
    func viewCompare(view: UIView) {
        view.addSubview(logo)

        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logo.widthAnchor.constraint(equalToConstant: 350),
            logo.heightAnchor.constraint(equalToConstant: 350),
        ])

    }
    
}
