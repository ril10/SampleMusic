//
//  RegistrationViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import Dip

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var coordinator : MainCoordinator?
    var viewModel : RegistrationViewModel!

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
        label.text = "Sign Up"
        label.font = UIFont(name: "Avenir Heavy", size: 40.0)
        label.tintColor = .gray
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
        textField.underLine()
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
        textField.underLine()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    //MARK: - MiddleView
    var radioLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your role*"
        label.font = UIFont(name: "Avenir Light", size: 15.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var radioUser: UIButton = {
        let button = UIButton()
        button.setTitle("User", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tintColor = UIColor.black
        button.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 15)
        button.addTarget(self, action: #selector(userSelected(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var radioSeller: UIButton = {
        let button = UIButton()
        button.setTitle("Seller", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 15)
        button.tintColor = UIColor.black
        button.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        button.addTarget(self, action: #selector(sellerSelected(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - BottomView
    var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "mainScreenRed")
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 10
        button.addTarget(self, action: #selector(continueButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Have an Account?"
        label.font = UIFont(name: "Avenir Light", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor(named: "mainScreenRed"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 15)
        button.addTarget(self, action: #selector(signInButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func userSelected(sender: UIButton!) {
        viewModel.isRole = true
        viewModel.roleChoose("user")
        if radioUser.currentImage == UIImage(systemName: "smallcircle.circle") {
            radioUser.setImage(UIImage(systemName: "smallcircle.fill.circle"), for: .normal)
            radioSeller.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        }
    }
    
    @objc func sellerSelected(sender: UIButton!) {
        viewModel.isRole = true
        viewModel.roleChoose("seller")
        if radioSeller.currentImage == UIImage(systemName: "smallcircle.circle") {
            radioSeller.setImage(UIImage(systemName: "smallcircle.fill.circle"), for: .normal)
            radioUser.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        }
    }
    
    @objc func continueButton(sender: UIButton!) {
        if !viewModel.isRole {
            self.errorWithRole()
        } else {
            viewModel.registerUser(email: loginTextField.text!, password: passwordTextField.text!)
        }
    }
    
    @objc func signInButton(sender: UIButton!) {
        coordinator?.start()
    }
    //MARK: - Alert
    func errorWithRegistration(e: Error) {
        let alert = UIAlertController(title: "Error Sign Up", message: e.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorWithRole() {
        let alert = UIAlertController(title: "Error Sign Up", message: "Select your role", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        return false
    }
    //MARK: - Constraints
    func viewCompare() {
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
    //MARK: - ViewLoad
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        viewCompare()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.delegate = self
        passwordTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        viewModel.reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.view.setNeedsDisplay()
            }
        }
        viewModel.error = { error in
            self.errorWithRegistration(e: error)
        }
        
        viewModel.navToAdd = { nav in
            if nav {
                self.coordinator?.addUserData(role: self.viewModel.roleSet,docId: self.viewModel.docId)
            }
        }
    }
    
}
