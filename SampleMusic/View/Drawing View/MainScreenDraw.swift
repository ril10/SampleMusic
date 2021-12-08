//
//  MainScreenDraw.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 1.11.21.
//

import UIKit
import Dip

class MainScreenDraw : UIView {
    
    //MARK: - StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView,middleView,bottomView])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewTop: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topImage,topLabel])
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewMiddle: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [middleLabelSign,middleLabelWelcome,loginLabel,loginTextField,passwordLabel,passwordTextField])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewBottom: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [forgetButton,signUpButton])
        stackView.alignment = .bottom
        stackView.distribution = .fillProportionally
        stackView.spacing = 50
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - ViewUnderStack
    var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var middleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Components in View
    //MARK: - TopView
    var topLabel: UILabel = {
        let label = UILabel()
        label.text = Style.appName.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var topImage: UIImageView = {
        let image = UIImageView()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        image.image = UIImage(systemName: Icons.logoApp.rawValue,withConfiguration: largeConfig)
        image.tintColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    //MARK: - MiddleView
    var middleLabelSign: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(MainKeys.signIn.rawValue, comment: "")
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 30)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var middleLabelWelcome: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(MainKeys.welcome.rawValue, comment: "")
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        label.tintColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loginLabel: UILabel = {
        let label = UILabel()
        label.redLabel(title: NSLocalizedString(MainKeys.email.rawValue, comment: ""))
        return label
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.redLabel(title: NSLocalizedString(MainKeys.password.rawValue, comment: ""))
        return label
    }()
    
    var loginTextField: UITextField = {
        let textField = UITextField()
        textField.underLine()
        textField.loginTextField()
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.underLine()
        textField.passwordTextField()
        return textField
    }()
    
    var signButton: UIButton = {
        let button = UIButton()
        button.coraleButton(title: NSLocalizedString(MainKeys.signIn.rawValue, comment: ""))
        return button
    }()
    
    var forgetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle(NSLocalizedString(SignUpKeys.forgetPassw.rawValue, comment: ""), for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.coralLighButton(title: NSLocalizedString(MainKeys.signUp.rawValue, comment: ""))
        return button
    }()
    //MARK: - Constraints
    func viewCompare(view: UIView) {
        view.addSubview(stackView)
        stackView.addSubview(stackViewTop)
        stackView.addSubview(stackViewMiddle)
        stackView.addSubview(stackViewBottom)
        bottomView.addSubview(signButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -40),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            stackViewTop.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            stackViewTop.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewMiddle.topAnchor.constraint(equalTo: middleView.topAnchor),
            loginTextField.widthAnchor.constraint(equalTo: middleView.widthAnchor,constant: -20),
            passwordTextField.widthAnchor.constraint(equalTo: middleView.widthAnchor,constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackViewBottom.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            stackViewBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            stackViewBottom.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor,constant: -40),
            signButton.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 40),
            signButton.widthAnchor.constraint(equalTo: stackViewBottom.widthAnchor),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            stackViewBottom.topAnchor.constraint(equalTo: signButton.bottomAnchor,constant: 10)
        ])
        
    }
}
