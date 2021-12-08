//
//  RegistrationViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import Dip

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    var coordinator : RegistrationCoordinator?
    var viewModel : RegistrationControllerImp!
    var drawView = RegistrationViewDraw()
    
    init(viewModel: RegistrationControllerImp) {
        self.viewModel = viewModel
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
        coordinator?.finish()
        textFieldShouldClear(drawView.loginTextField)
        textFieldShouldClear(drawView.passwordTextField)
        drawView.radioUser.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
        drawView.radioUser.tintColor = UIColor.white
        drawView.radioSeller.tintColor = UIColor.white
        drawView.radioSeller.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
        
    }
    //MARK: - Alert
    func errorWithRegistration(e: Error) {
        let signTitle = NSLocalizedString(ErrorKeys.eSignUp.rawValue, comment: "")
        let okTitle = NSLocalizedString(MainKeys.ok.rawValue, comment: "")
        let alert = UIAlertController(title: signTitle, message: e.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorWithRole() {
        let signTitle = NSLocalizedString(ErrorKeys.eSignUp.rawValue, comment: "")
        let okTitle = NSLocalizedString(MainKeys.ok.rawValue, comment: "")
        let roleTitle = NSLocalizedString(SignUpKeys.choseRole.rawValue, comment: "")
        let alert = UIAlertController(title: signTitle, message: roleTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadAlertView() {
        let loadTitle = NSLocalizedString(MainKeys.loading.rawValue, comment: "")
        let waitTitle = NSLocalizedString(MainKeys.wait.rawValue, comment: "")
        let alert = UIAlertController(title: loadTitle, message: waitTitle, preferredStyle: .alert)
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

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text?.removeAll()
        return true
    }
    //MARK: - ViewLoad
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
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
                    self.coordinator?.parentCoordinator?.addUserData(role: (self.viewModel?.roleSet)!,docId: (self.viewModel?.docId)!)
                }
            }
        }
    }
}
extension RegistrationViewController : RegistrationScreenProtocol {}
