//
//  UserDetailViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import UIKit


class UserDetailViewController : UIViewController {
    
    var viewModel : UserDetailViewModelImp!
    var coordinator : UserDetailCoordinator?
    var drawView = UserDetailDrawView()
    
    init(viewModel: UserDetailViewModelImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 //MARK: - View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.userData()
    }
    
    override func loadView() {
        super.loadView()
        configureNavBar()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.view.setNeedsDisplay()
            }
        }
        viewModel.fieldData = { [weak self] firstName,lastName,desc,email,gender in
            self?.drawView.firstNameData.text = firstName
            self?.drawView.secondNameData.text = lastName
            self?.drawView.descriptionData.text = desc
            self?.drawView.emailData.text = email
            self?.drawView.genderData.text = gender
        }
        viewModel.image = { [weak self] image in
            self?.drawView.imageView.image = UIImage(data: image)
        }
        
        title = "User Detail"
    }
    //MARK: - ActionButton
    @objc func editAction(sender: UIButton) {
        
    }
    
    @objc func message(sender: UIButton) {
        coordinator?.navToChatList()
    }
    //MARK: - Config NavBar
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.colorButton.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        nav?.isTranslucent = true
        nav?.barTintColor = .white
        nav?.topItem?.title = "User Detail"
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editAction(sender:)))
        let message = UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: #selector(message(sender:)))
        self.navigationItem.rightBarButtonItems = [edit, message]
    }
}

extension UserDetailViewController : UserDetailProtocol {}
