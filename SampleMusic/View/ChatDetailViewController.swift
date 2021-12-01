//
//  ChatDetailViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit

class ChatDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
        let cellVm = self.viewModel.getCellModel(at: indexPath)
        cell.messageCell = cellVm

        viewModel.ifUserSign()
        viewModel.ifSellerSign()
        viewModel.userSign = { sign in
            cell.leftImage.isHidden = true
            cell.rightImage.isHidden = false
        }
        viewModel.sellerSign = { sign in
            cell.leftImage.isHidden = false
            cell.rightImage.isHidden = true
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    //MARK: UITextFieldDelegate
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text?.removeAll()
        return true
    }
    //MARK: - Action Button
    
    @objc func sendMessage(sender: UIButton) {
        viewModel.ifUserSign()
        viewModel.ifSellerSign()
        viewModel.userSign = { sign in
            if sign {
                self.viewModel.sendMessage(text: self.drawView.messageTextField.text!)
                self.textFieldShouldClear(self.drawView.messageTextField)
            }
        }
        viewModel.sellerSign = { sign in
            if sign {
                self.viewModel.sendMessageIfSeller(text: self.drawView.messageTextField.text!)
                self.textFieldShouldClear(self.drawView.messageTextField)
            }
        }
    }

    //MARK: - View
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadMessages()
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(ChatDetailCell.self, forCellReuseIdentifier: TableCell.chatDetailCell.rawValue)
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        title = "Chat"
        drawView.sendMessage.addTarget(self, action: #selector(sendMessage(sender:)), for: .touchUpInside)
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.drawView.sampleTable.reloadData()
            }
        }
    }

}

extension ChatDetailViewController : ChatDetailProtocol {}
