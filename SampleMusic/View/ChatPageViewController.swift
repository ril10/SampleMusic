//
//  ChatPageViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import UIKit


class ChatPageViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {

    var drawView = ChatPageDrawView()
    var coordinator : ChatPageCoordinator?
    var viewModel : ChatPageImp
    
    init(viewModel: ChatPageImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.chatCell.rawValue, for: indexPath) as! ChatListCell
        let cellVm = viewModel.getCellModel(at: indexPath)
        
        cell.chatSell = cellVm
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVm = viewModel.getCellModel(at: indexPath)
        coordinator?.goToChatDetail(ownerUid: cellVm.ownerUid, chatRoom: cellVm.chatRoom, recieverUid: cellVm.recieverUid)
    }
    //MARK: - View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.ifSellerSign()
        viewModel.ifUserSign()
        
        viewModel.sellerSign = { log in
            if log {
                self.viewModel.loadMessages()
            }
        }
        
        viewModel.userSign = { log in
            if log {
                self.viewModel.loadMessageIfUser()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(ChatListCell.self, forCellReuseIdentifier: TableCell.chatCell.rawValue)
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        viewModel.reloadTableView = { [weak self] in
            self?.drawView.sampleTable.reloadData()
        }
        title = NSLocalizedString(ChatKeys.chatList.rawValue, comment: "")
    }
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.coralColor.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        nav?.isTranslucent = true
        nav?.barTintColor = .white
        nav?.topItem?.title = NSLocalizedString(ChatKeys.chatList.rawValue, comment: "")
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
}

extension ChatPageViewController : ChatPageProtocol {}
