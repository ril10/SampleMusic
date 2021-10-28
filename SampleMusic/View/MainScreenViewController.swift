//
//  ViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import Dip

class MainScreenViewController: UIViewController, UITextFieldDelegate {
    
    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel : MainScreenViewModel!
    
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
        label.text = Style.appName.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var topImage: UIImageView = {
        let image = UIImageView()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        image.image = UIImage(systemName: Style.logoApp.rawValue,withConfiguration: largeConfig)
        image.tintColor = .lightGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    //MARK: - MiddleView
    var middleLabelSign: UILabel = {
        let label = UILabel()
        label.text = Titles.signIn.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 30)
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var middleLabelWelcome: UILabel = {
        let label = UILabel()
        label.text = Titles.welcome.rawValue
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        label.tintColor = .lightGray
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
    
    //MARK: - BottomView
    
    var signButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: Style.colorButton.rawValue)
        button.setTitle(Titles.signIn.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 10
        button.addTarget(self, action: #selector(signInAction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func signInAction(sender: UIButton!) {
        viewModel.userSignIn(email: loginTextField.text!, password: passwordTextField.text!)
    }
    
    var forgetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle(Titles.forgetPassword.rawValue, for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont(name: Style.fontTitleLight.rawValue, size: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle(Titles.signUp.rawValue, for: .normal)
        button.setTitleColor(UIColor(named: Style.colorButton.rawValue), for: .normal)
        button.titleLabel?.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 15)
        button.addTarget(self, action: #selector(registrationButtonAction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func registrationButtonAction(sender: UIButton!) {
        coordinator?.registrationViewController()
    }
    //MARK: - Alert
    func errorWithLogin(e: Error) {
        let alert = UIAlertController(title: AlertTitle.errorSignIn.rawValue, message: e.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Titles.ok.rawValue, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.loginTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        return false
    }
    //MARK: - View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        viewModel.reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.view.setNeedsDisplay()
            }
        }
        viewModel.error = { error in
            self.errorWithLogin(e: error)
        }
        self.hideKeyboardWhenTappedAround()
    }
    //MARK: - Constraints
    func viewCompare() {
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

