//
//  ViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 25.10.21.
//

import UIKit
import Dip


class MainScreenViewController: UIViewController, UITextFieldDelegate {
    
    init(viewModel: MainControllerImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var viewModel : MainControllerImp!
    var drawView = MainScreenDraw()
    var coordinator: MainScreenCoordinator?

    //MARK: - ButtonAction
    @objc func signInAction(sender: UIButton!) {
        viewModel.userSignIn(email: drawView.loginTextField.text!, password: drawView.passwordTextField.text!)
        viewModel.loading = { [self] load in
            if load {
                loadAlertView()
            } else {
                viewModel.error = { [self] error in
                    errorWithLogin(e: error)
                }
            }
        }
    }
    
    @objc func registrationButtonAction(sender: UIButton!) {
        self.coordinator?.goToRegistrationPage()
        self.textFieldShouldClear(drawView.loginTextField)
        self.textFieldShouldClear(drawView.passwordTextField)
    }
    
    
    @objc func showPassword(sender: UIButton!) {
        drawView.showPassword.isSelected.toggle()
        if drawView.showPassword.isSelected {
            drawView.showPassword.setImage(UIImage(systemName: Icons.crossEye.rawValue), for: .normal)
        } else {
            drawView.showPassword.setImage(UIImage(systemName: Icons.eye.rawValue), for: .normal)
        }
        drawView.passwordTextField.isSecureTextEntry.toggle()
    }
    //MARK: - Alert
    func errorWithLogin(e: Error) {
        let alertTitle = NSLocalizedString(ErrorKeys.eSignIn.rawValue, comment: "")
        let okTitle = NSLocalizedString(MainKeys.ok.rawValue, comment: "")
        let alert = UIAlertController(title: alertTitle, message: e.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadAlertView() {
        let loadTitle = NSLocalizedString(MainKeys.loading.rawValue, comment: "")
        let waitTitile = NSLocalizedString(MainKeys.wait.rawValue, comment: "")
        let alert = UIAlertController(title: loadTitle, message: waitTitile, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        viewModel.dismisAlert = { load in
            if load {
                alert.dismiss(animated: false)
            }
        }
        NSLayoutConstraint.activate([
            loadingIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor),
        ])
        self.present(alert, animated: true)
    }
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        drawView.loginTextField.endEditing(true)
        drawView.passwordTextField.endEditing(true)
        return false
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text?.removeAll()
        drawView.showPassword.isHidden = true
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        drawView.showPassword.isHidden = false
        drawView.showPassword.center.x -= view.bounds.width
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
            self.drawView.showPassword.center.x += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //MARK: - View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawView.showPassword.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = UIColor(named: Style.backgroundColor.rawValue)
        
        drawView.viewCompare(view: view)
        drawView.signButton.addTarget(self, action: #selector(signInAction(sender:)), for: .touchUpInside)
        drawView.signUpButton.addTarget(self, action: #selector(registrationButtonAction(sender:)), for: .touchUpInside)
        drawView.showPassword.addTarget(self, action: #selector(showPassword(sender:)), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.loginTextField.delegate = self
        drawView.passwordTextField.delegate = self
        viewModel.reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.view.setNeedsDisplay()
            }
        }
        
        viewModel.loadCompleteUser = { [weak self] load in
            if load {
                self?.dismiss(animated: true, completion: {
                    self?.coordinator?.finish()
                    self?.coordinator?.goToUser()
                    self?.textFieldShouldClear(self!.drawView.loginTextField)
                    self?.textFieldShouldClear(self!.drawView.passwordTextField)
                })
            }
        }
        viewModel.loadCompleteSeller = { [weak self] load in
            if load {
                self?.dismiss(animated: true, completion: {
                    self?.coordinator?.finish()
                    self?.coordinator?.goToSeller()
                    self?.textFieldShouldClear(self!.drawView.loginTextField)
                    self?.textFieldShouldClear(self!.drawView.passwordTextField)
                })
                
            }
        }
        
        self.hideKeyboardWhenTappedAround()
    }
    
}

extension MainScreenViewController : MainScreenProtocol {}
