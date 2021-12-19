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
    var startView: CustomViewAnimation = .makeBiggerLower(duration: 1.5, delayFactor: 0.05, springWithDamb: 0.2, springVelocity: 0.0)
        
    //MARK: - View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let animation = startView.getAnimation()
        let animator = AnimatedView(animation: animation)
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            animator.animate(view: self.drawView.logo)
        }
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor(named: Style.backgroundColor.rawValue)
        
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            self.coordinator?.finish()
            self.coordinator?.mainScreenView()
        }
    }
    
    
}

extension StartViewController: StartViewProtocol {}
