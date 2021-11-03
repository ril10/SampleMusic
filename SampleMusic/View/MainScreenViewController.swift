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
    var drawView = MainScreenDraw()
    var coordinator: MainCoordinator?
    
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
        coordinator?.registrationViewController()
    }
    //MARK: - Alert
    func errorWithLogin(e: Error) {
        let alert = UIAlertController(title: AlertTitle.errorSignIn.rawValue, message: e.localizedDescription, preferredStyle: .alert)
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
        viewModel.navSeller = { load in
            if load {
                alert.dismiss(animated: true) {
                    self.coordinator?.sellerDetailViewController()
                }
            }
        }
        viewModel.navUser = { load in
            if load {
                alert.dismiss(animated: true) {
                    self.coordinator?.listSamplesViewController()
                }
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
    //MARK: - View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        
        drawView.viewCompare(view: view)
        drawView.signButton.addTarget(self, action: #selector(signInAction(sender:)), for: .touchUpInside)
        drawView.signUpButton.addTarget(self, action: #selector(registrationButtonAction(sender:)), for: .touchUpInside)
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
//        viewModel.navUser = { nav in
//            if nav {
//                self.coordinator?.listSamplesViewController()
//            }
//        }
//        viewModel.navSeller = { nav in
//            if nav {
//                self.coordinator?.sellerDetailViewController()
//            }
//        }
        self.hideKeyboardWhenTappedAround()
    }

}

