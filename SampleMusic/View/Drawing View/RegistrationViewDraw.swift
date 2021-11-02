//
//  RegistrationViewDraw.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 2.11.21.
//

import UIKit
import Dip

class RegistrationViewDraw : UIView {
    
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
        let stackView = UIStackView(arrangedSubviews: [topLabel,loginLabel,loginTextField,passwordLabel,passwordTextField])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewMiddle: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [radioUser,radioSeller])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewBottom: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [accountLabel,signInButton])
        stackView.alignment = .center
        stackView.distribution = .fill
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
        label.text = Titles.signUp.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 40.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loginLabel: UILabel = {
        let label = UILabel()
        label.text = Titles.email.rawValue
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Titles.password.rawValue
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loginTextField: UITextField = {
        let textField = UITextField()
        textField.loginTextField()
        textField.underLine()
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.passwordTextField()
        textField.underLine()
        return textField
    }()
    
    //MARK: - MiddleView
    var radioLabel: UILabel = {
        let label = UILabel()
        label.text = Role.chooseRole.rawValue
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var radioUser: UIButton = {
        let button = UIButton()
        button.radioButton(title: Role.user.rawValue)
        return button
    }()
    
    var radioSeller: UIButton = {
        let button = UIButton()
        button.radioButton(title: Role.seller.rawValue)
        return button
    }()
    
    //MARK: - BottomView
    var registerButton: UIButton = {
        let button = UIButton()
        button.coraleButton(title: Titles.contin.rawValue)
        return button
    }()
    
    var accountLabel: UILabel = {
        let label = UILabel()
        label.text = Titles.haveAcc.rawValue
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    var signInButton: UIButton = {
        let button = UIButton()
        button.coralLighButton(title: Titles.signIn.rawValue)
        return button
    }()
    
    //MARK: - Constraints
    func viewCompare(view: UIView) {
        view.addSubview(stackView)
        stackView.addSubview(stackViewTop)
        stackView.addSubview(stackViewMiddle)
        stackView.addSubview(stackViewBottom)
        bottomView.addSubview(registerButton)
        middleView.addSubview(radioLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -40),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackViewTop.topAnchor.constraint(equalTo: topView.topAnchor,constant: 30),
            stackViewTop.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            loginTextField.widthAnchor.constraint(equalTo: topView.widthAnchor,constant: -20),
            passwordTextField.widthAnchor.constraint(equalTo: topView.widthAnchor,constant: -20),

        ])
        
        NSLayoutConstraint.activate([
            radioLabel.topAnchor.constraint(equalTo: middleView.topAnchor,constant: 20),
            radioLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            stackViewMiddle.topAnchor.constraint(equalTo: radioLabel.bottomAnchor,constant: 20),
            stackViewMiddle.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor,constant: 40),
            stackViewBottom.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor,constant: -40),
            stackViewBottom.topAnchor.constraint(equalTo: registerButton.bottomAnchor,constant: 40),
            registerButton.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 40),
            registerButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
