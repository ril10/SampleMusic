//
//  RegistrationViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import Dip

class RegistrationViewController: UIViewController, UITextFieldDelegate,ContainerImp {
    
    
    var coordinator : MainCoordinatorImp?
    var viewModel : RegistrationControllerImp!
    var drawView = RegistrationViewDraw()
    var container : DependencyContainer!
    
    init() {
        self.container = appContainer
        self.viewModel = try! container.resolve() as RegistrationControllerImp
        self.coordinator = try! container.resolve() as MainCoordinatorImp
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - ButtonAction
    @objc func userSelected(sender: UIButton!) {
        viewModel.isRole = true
        viewModel.roleChoose(Role.user.rawValue.lowercased())
        if drawView.radioUser.currentImage == UIImage(systemName: Icons.radioOff.rawValue) {
            drawView.radioUser.setImage(UIImage(systemName: Icons.radioOn.rawValue), for: .normal)
            drawView.radioUser.tintColor = UIColor.black
            drawView.radioSeller.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioSeller.tintColor = UIColor.white
        }
    }
    
    @objc func sellerSelected(sender: UIButton!) {
        viewModel.isRole = true
        viewModel.roleChoose(Role.seller.rawValue.lowercased())
        if drawView.radioSeller.currentImage == UIImage(systemName: Icons.radioOff.rawValue) {
            drawView.radioSeller.setImage(UIImage(systemName: Icons.radioOn.rawValue), for: .normal)
            drawView.radioSeller.tintColor = UIColor.black
            drawView.radioUser.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioUser.tintColor = UIColor.white
        }
    }
    
    @objc func continueButton(sender: UIButton!) {
        viewModel.registerUser(email: drawView.loginTextField.text!, password: drawView.passwordTextField.text!)
        if !(viewModel?.isRole ?? false) {
            self.errorWithRole()
        } else {
            viewModel.registerUser(email: drawView.loginTextField.text!, password: drawView.passwordTextField.text!)
        }
        
       viewModel.loading = { [self] load in
            if load {
                loadAlertView()
            } else {
                viewModel?.error = { [self] error in
                    errorWithRegistration(e: error)
                }
            }
        }
    }
    
    @objc func signInButton(sender: UIButton!) {
        coordinator?.logout()
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
        let alert = UIAlertController(title: AlertTitle.loading.rawValue, message: AlertTitle.wait.rawValue, preferredStyle: .alert)
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
        self.drawView.loginTextField.endEditing(true)
        self.drawView.passwordTextField.endEditing(true)
        return false
    }

    //MARK: - ViewLoad
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
        drawView.radioUser.addTarget(self, action: #selector(userSelected(sender:)), for: .touchUpInside)
        drawView.radioSeller.addTarget(self, action: #selector(sellerSelected(sender:)), for: .touchUpInside)
        drawView.registerButton.addTarget(self, action: #selector(continueButton(sender:)), for: .touchUpInside)
        drawView.signInButton.addTarget(self, action: #selector(signInButton(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.loginTextField.delegate = self
        drawView.passwordTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        viewModel.reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.view.setNeedsDisplay()
            }
        }        
        viewModel.navToAdd = { nav in
            if nav {
                self.dismiss(animated: true) {
                    self.coordinator?.addUserData(role: (self.viewModel?.roleSet)!,docId: (self.viewModel?.docId)!)
                }
            }
        }
    }
}
