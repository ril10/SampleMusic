//
//  ChatDetailViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit
import SDWebImage

class ChatDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var viewModel : ChatDetailimp
    
    init(viewModel: ChatDetailimp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var coordinator : ChatDetailCoordinator?
    var drawView = ChatDetailDrawView()
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.chatDetailCell.rawValue, for: indexPath) as! ChatDetailCell
        let cellVm = viewModel.getCellModel(at: indexPath)
        cell.messageCell = cellVm
        
        if cellVm.senderUid == viewModel.checkCurrentUser() {
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
        } else {
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVm = self.viewModel.getCellModel(at: indexPath)
        print(cellVm.senderUid)
        print(cellVm.recieverUid)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellVm = self.viewModel.getCellModel(at: indexPath)
        let rowHeight : CGFloat = 70
        if cellVm.body.count > 25 {
            return UITableView.automaticDimension
        } else {
            return rowHeight
        }
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text?.removeAll()
        return true
    }
    
    //MARK: - Action Button
    
    @objc func sendMessage(sender: UIButton) {
        self.viewModel.sendMessage(text: self.drawView.messageTextField.text!)
        self.textFieldShouldClear(self.drawView.messageTextField)
    }
    
    //MARK: - View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
        viewModel.loadMessages()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.coralColor.rawValue) as Any
        ]
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor(named: Style.backgroundColor.rawValue)
        drawView.viewCompare(view: view)
        drawView.sendMessage.addTarget(self, action: #selector(sendMessage(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(ChatDetailCell.self, forCellReuseIdentifier: TableCell.chatDetailCell.rawValue)
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        drawView.sampleTable.estimatedRowHeight = 70
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.drawView.sampleTable.reloadData()
                if (self?.viewModel.messageData.count)! > 0 {
                    let indexPath = IndexPath(row: (self?.viewModel.messageData.count)! - 1, section: 0)
                    self?.drawView.sampleTable.scrollToRow(at: indexPath, at: .top, animated: true)
                    self?.drawView.sampleTable.reloadData()
                }
            }
        }
        title = NSLocalizedString(ChatKeys.chatDetail.rawValue, comment: "")

        self.hideKeyboardWhenTappedAround()
    }
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        nav?.isTranslucent = true
        nav?.barTintColor = .white
        nav?.topItem?.title = NSLocalizedString(ChatKeys.chatDetail.rawValue, comment: "")
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.setHidesBackButton(false, animated: true)
    }

}

extension ChatDetailViewController : ChatDetailProtocol {}

