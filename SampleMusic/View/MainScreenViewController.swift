//
//  ViewController.swift
//  SampleMusic
//
//  Created by administrator on 25.10.21.
//

import UIKit

class MainScreenViewController: UIViewController, UITextFieldDelegate {

    var coordinator: MainCoordinator?
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
       label.text = "Music Sample"
        label.font = UIFont(name: "Avenir Heavy", size: 20.0)
        label.tintColor = .gray
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    var topImage: UIImageView = {
       let image = UIImageView()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        image.image = UIImage(systemName: "cloud.fill",withConfiguration: largeConfig)
        image.tintColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    //MARK: - MiddleView
    var middleLabelSign: UILabel = {
       let label = UILabel()
        label.text = "Sign In"
        label.font = UIFont(name: "Avenir Heavy", size: 30)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var middleLabelWelcome: UILabel = {
        let label = UILabel()
        label.text = "Welcome there"
        label.font = UIFont(name: "Avenir Light", size: 15)
        label.tintColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "Avenir Light", size: 15)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "Avenir Light", size: 15)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your login"
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.underLine(width: 300)
        textField.translatesAutoresizingMaskIntoConstraints = false
       return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.isSecureTextEntry = true
        textField.underLine(width: 300)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - BottomView

    var signButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        button.backgroundColor = .red
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var forgetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Light", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        
        viewCompare()
    }
    //MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func viewCompare() {
        view.addSubview(stackView)
        stackView.addSubview(stackViewTop)
        stackView.addSubview(stackViewMiddle)
        stackView.addSubview(stackViewBottom)
        bottomView.addSubview(signButton)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackViewTop.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            stackViewTop.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewMiddle.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 20),
            stackViewMiddle.topAnchor.constraint(equalTo: middleView.topAnchor),
            loginTextField.widthAnchor.constraint(equalTo: middleView.widthAnchor,constant: -20),
            passwordTextField.widthAnchor.constraint(equalTo: middleView.widthAnchor,constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackViewBottom.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            stackViewBottom.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            stackViewBottom.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor,constant: -40),
            signButton.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 40),
            signButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor,constant: 40),
            signButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor,constant: -40),
            stackViewBottom.topAnchor.constraint(equalTo: signButton.bottomAnchor,constant: 20)
        ])
        
    }
    
    

}

