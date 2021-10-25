//
//  Extension.swift
//  SampleMusic
//
//  Created by administrator on 25.10.21.
//

import UIKit

extension UITextField {
    func underLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 25.0, width: 300, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(bottomLine)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
