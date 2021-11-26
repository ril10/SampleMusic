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
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.chatCell.rawValue, for: indexPath) as! ChatListCell
        cell.lastMessage.text = "Lorem ispum"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //MARK: - View
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        configureNavBar()
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(ChatListCell.self, forCellReuseIdentifier: TableCell.chatCell.rawValue)
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        title = "Chat List"
    }
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.colorButton.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        nav?.isTranslucent = true
        nav?.barTintColor = .white
        nav?.topItem?.title = "Chat List"
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
    }
    
}

extension ChatPageViewController : ChatPageProtocol {}
