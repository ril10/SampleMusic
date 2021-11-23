//
//  Extension.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit

extension UITextField {
    func underLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: 25.0, width: 300, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        self.layer.addSublayer(bottomLine)
    }
    func loginTextField() {
        self.placeholder = TextFieldLabel.enterLog.rawValue
        self.borderStyle = UITextField.BorderStyle.none
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.emailAddress
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func passwordTextField() {
        self.placeholder = TextFieldLabel.enterPassword.rawValue
        self.borderStyle = UITextField.BorderStyle.none
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.default
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        self.isSecureTextEntry = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func defaultTextField(placeholder: String) {
        self.placeholder = placeholder
        self.borderStyle = UITextField.BorderStyle.none
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.default
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextField.ViewMode.whileEditing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIButton {
    func coraleButton(title: String) {
        self.backgroundColor = UIColor(named: Style.colorButton.rawValue)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    func coralLighButton(title: String) {
        self.backgroundColor = .clear
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor(named: Style.colorButton.rawValue), for: .normal)
        self.titleLabel?.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 15)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func radioButton(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
        self.tintColor = UIColor.white
        self.imageView?.layer.borderWidth = 1
        self.imageView?.layer.borderColor = UIColor.black.cgColor
        self.imageView?.layer.cornerRadius = 10
        self.imageView?.clipsToBounds = true
        self.titleLabel?.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UILabel {
    func redLabel(title: String) {
        self.text = title
        self.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        self.textColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60 % 60
        let second = Int(time) & 60
        return String(format: "%02i:%02i", minute, second)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func blurView() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 1
        self.addSubview(blurEffectView)
    }
    func removeBlur() {
        self.viewWithTag(1)?.removeFromSuperview()
    }
}
