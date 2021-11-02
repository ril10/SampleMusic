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
        textField.placeholder = TextFieldLabel.enterLog.rawValue
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
        textField.placeholder = TextFieldLabel.enterPassword.rawValue
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
        label.text = Role.chooseRole.rawValue
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var radioUser: UIButton = {
        let button = UIButton()
        button.setTitle(Role.user.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(UIImage(systemName: Style.radioOff.rawValue), for: .normal)
        button.tintColor = UIColor.white
        button.imageView?.layer.borderWidth = 1
        button.imageView?.layer.borderColor = UIColor.black.cgColor
        button.imageView?.layer.cornerRadius = 10
        button.imageView?.clipsToBounds = true
        button.titleLabel?.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20)
        button.addTarget(self, action: #selector(userSelected(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var radioSeller: UIButton = {
        let button = UIButton()
        button.setTitle(Role.seller.rawValue, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20)
        button.tintColor = UIColor.white
        button.imageView?.layer.borderWidth = 1
        button.imageView?.layer.borderColor = UIColor.black.cgColor
        button.imageView?.layer.cornerRadius = 10
        button.imageView?.clipsToBounds = true
        button.setImage(UIImage(systemName: Style.radioOff.rawValue), for: .normal)
        button.addTarget(self, action: #selector(sellerSelected(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - BottomView
    var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: Style.colorButton.rawValue)
        button.setTitle(Titles.contin.rawValue, for: .normal)
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
        label.text = Titles.haveAcc.rawValue
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle(Titles.signIn.rawValue, for: .normal)
        button.setTitleColor(UIColor(named: Style.colorButton.rawValue), for: .normal)
        button.titleLabel?.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 15)
        button.addTarget(self, action: #selector(signInButton(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func userSelected(sender: UIButton!) {
        viewModel.isRole = true
        viewModel.roleChoose(Role.user.rawValue.lowercased())
        if radioUser.currentImage == UIImage(systemName: Style.radioOff.rawValue) {
            radioUser.setImage(UIImage(systemName: Style.radioOn.rawValue), for: .normal)
            radioUser.tintColor = UIColor.black
            radioSeller.setImage(UIImage(systemName: Style.radioOff.rawValue), for: .normal)
            radioSeller.tintColor = UIColor.white
        }
    }
    
    @objc func sellerSelected(sender: UIButton!) {
        viewModel.isRole = true
        viewModel.roleChoose(Role.seller.rawValue.lowercased())
        if radioSeller.currentImage == UIImage(systemName: Style.radioOff.rawValue) {
            radioSeller.setImage(UIImage(systemName: Style.radioOn.rawValue), for: .normal)
            radioSeller.tintColor = UIColor.black
            radioUser.setImage(UIImage(systemName: Style.radioOff.rawValue), for: .normal)
            radioUser.tintColor = UIColor.white
        }
    }
    
    @objc func continueButton(sender: UIButton!) {
        viewModel.registerUser(email: loginTextField.text!, password: passwordTextField.text!)
        if !(viewModel.isRole ?? false) {
            self.errorWithRole()
        } else {
            viewModel.registerUser(email: loginTextField.text!, password: passwordTextField.text!)
        }
        
       viewModel.loading = { [self] load in
            if load {
                loadAlertView()
            } else {
                viewModel.error = { [self] error in
                    errorWithRegistration(e: error)
                }
            }
        }
    }
    
    @objc func signInButton(sender: UIButton!) {
        coordinator?.start()
    }
    //MARK: - Alert
    func errorWithRegistration(e: Error) {
        let alert = UIAlertController(title: AlertTitle.errorSignUp.rawValue, message: e.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Titles.ok.rawValue, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorWithRole() {
        let alert = UIAlertController(title: AlertTitle.errorSignUp.rawValue, message: AlertTitle.selectRole.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Titles.ok.rawValue, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadAlertView() {
        let alert = UIAlertController(title: "Loading", message: "Please wait...", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor),
        ])
        self.present(alert, animated: true)
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
        viewModel.navToAdd = { nav in
            if nav {
                self.dismiss(animated: true) {
                    self.coordinator?.addUserData(role: self.viewModel.roleSet,docId: self.viewModel.docId)
                }
            }
        }
    }
    
}
