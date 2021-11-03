//
//  SellerDetailViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 27.10.21.
//

import UIKit

class SellerDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    init(viewModel: SellerDetailViewModel,drawView: SellerDetailDraw) {
        self.viewModel = viewModel
        self.drawView = drawView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var coordinator : MainCoordinator?
    var drawView : SellerDetailDraw!
    var viewModel : SellerDetailViewModel!

    //MARK: - ButtonAction
    @objc func editData(sender: UIButton!) {
        
    }
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell",for: indexPath) as! CustomTableViewCell
        cell.labelSample.text = "Some say"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - View
    override func loadView() {
        super.loadView()
        configureNavBar()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        title = "Seller Detail"
        
    }
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.colorButton.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        nav?.isTranslucent = true
        nav?.barTintColor = .white
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editData(sender:)))
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    
}
