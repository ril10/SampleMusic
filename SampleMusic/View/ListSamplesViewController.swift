//
//  ListSamplesViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import UIKit
import Dip

class ListSamplesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,ContainerImp {
    var container: DependencyContainer!
    
        
    var coordinator : MainCoordinatorImp?
    var drawView = ListSamplesDraw()
    var viewModel : ListSamplesImp!
    
    init() {
        self.container = appContainer
        self.viewModel = try! container.resolve() as ListSamplesImp
        self.coordinator = try! container.resolve() as MainCoordinatorImp
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell",for: indexPath) as! CustomTableViewCell
        cell.labelSample.text = "Some say"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //MARK: - ActionButton
    @objc func logoutAction(sender: UIButton!) {
        viewModel?.logout()
    }
    //MARK: - View
    
    override func loadView() {
        super.loadView()
//        configureNavBar()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        viewModel?.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.drawView.sampleTable.reloadData()
            }
        }
        viewModel?.isLogout = { [weak self] log in
            if log {
                self?.coordinator?.logout()
            }
        }
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
        nav?.topItem?.title = "Samples"
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutAction(sender:)))
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
}
