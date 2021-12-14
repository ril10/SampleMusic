//
//  UserDetailViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import UIKit
import SDWebImage

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
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.userData()
        viewModel.fieldData = { [weak self] firstName,lastName,desc,email,gender,image in
            self?.drawView.firstNameData.text = firstName
            self?.drawView.secondNameData.text = lastName
            self?.drawView.descriptionData.text = desc
            self?.drawView.emailData.text = email
            self?.drawView.genderData.text = gender
            self?.drawView.imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(systemName: Icons.photo.rawValue))
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        title = ""
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor(named: Style.backgroundColor.rawValue)
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.reloadView = { [weak self] in
            DispatchQueue.main.async {
                self?.view.setNeedsDisplay()
            }
        }
        
        title = NSLocalizedString(DetailKeys.uDetail.rawValue, comment: "")
    }
    //MARK: - ActionButton
    @objc func message(sender: UIButton) {
        coordinator?.navToChatList()
    }
    //MARK: - Config NavBar
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.coralColor.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        nav?.isTranslucent = true
        nav?.barTintColor = .white
        nav?.topItem?.title = NSLocalizedString(DetailKeys.uDetail.rawValue, comment: "")
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()

        let message = UIBarButtonItem(image: UIImage(systemName: Icons.message.rawValue), style: .plain, target: self, action: #selector(message(sender:)))
        self.navigationItem.rightBarButtonItems = [message]
    }
}

extension UserDetailViewController : UserDetailProtocol {}
