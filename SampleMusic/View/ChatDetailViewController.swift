//
//  ChatDetailViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit

class ChatDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var coordinator : ChatDetailCoordinator?
    var drawView = ChatDetailDrawView()
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.chatDetailCell.rawValue, for: indexPath) as! ChatDetailCell
        
        cell.message.text = "Hello World!"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    //MARK: - View
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
        // Do any additional setup after loading the view.
    }

}

extension ChatDetailViewController : ChatDetailProtocol {}
