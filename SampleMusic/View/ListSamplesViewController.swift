//
//  ListSamplesViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.10.21.
//

import UIKit
import Dip

class ListSamplesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var coordinator : ListSamplesCoordinator?
    var drawView = ListSamplesDraw()
    var viewModel : ListSamplesImp!
    
    init(viewModel: ListSamplesImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cell.rawValue,for: indexPath) as! CustomTableViewCell
        let cellVm = self.viewModel.getCellModel(at: indexPath)
        cell.sampleCell = cellVm
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.samplesData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVm = self.viewModel.getCellModel(at: indexPath)
//        viewModel.getUid(cellVm.ownerUid)
        viewModel.createChatRoom(ownerUid: viewModel.curUser!, recieverUid: cellVm.ownerUid)
        coordinator?.goToSellerPage(ownerUid: cellVm.ownerUid,chatRoom: viewModel.chatRoom!)
    }
    //MARK: - Alert
    func alertLoading() {
        let alert = UIAlertController(title: AlertTitle.loading.rawValue, message: AlertTitle.wait.rawValue, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        view.blurView()
        alert.view.addSubview(loadingIndicator)
        viewModel.dismissAlert = { load in
            if load {
                alert.dismiss(animated: false)
                self.view.removeBlur()
            }
        }
        NSLayoutConstraint.activate([
            loadingIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor),
        ])
        
        self.present(alert, animated: true)
    }
    //MARK: - ActionButton
    @objc func logoutAction(sender: UIButton!) {
        viewModel?.logout()
        coordinator?.finish()
    }
    
    @objc func userDetail(sender: UIButton!) {
        coordinator?.goToDetailPage()
    }
    
    @objc func segmentAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.filterByName()
        case 1:
            viewModel.filterByTrackLength()
        default:
            break
        }
    }

    //MARK: - View
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        viewModel.userImage()
        if viewModel.samplesData.count == 0 {
            self.alertLoading()
            self.viewModel.getSamplesData()
        }
        viewModel.hideUserDetail()
        viewModel.hide = { hide in
            if hide {
                self.navigationItem.rightBarButtonItem?.image = nil
            }
        }

    }
    
    override func loadView() {
        super.loadView()
        configureNavBar()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
        drawView.segment.addTarget(self, action: #selector(ListSamplesViewController.segmentAction(sender:)), for: .valueChanged)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(CustomTableViewCell.self, forCellReuseIdentifier: TableCell.cell.rawValue)
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        drawView.searchController.searchBar.delegate = self
        drawView.searchController.hidesNavigationBarDuringPresentation = false
        drawView.searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        viewModel?.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.drawView.sampleTable.reloadData()
            }
        }
        viewModel.signUser()
        
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
        nav?.topItem?.title = "Samples"
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        self.navigationItem.searchController = drawView.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutAction(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(userDetail(sender:)))
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
}

//MARK: - SearchControllerDelegate
extension ListSamplesViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return viewModel.getSearchData()
        }

        viewModel.searchResults(text: textToSearch)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getSearchData()
    }
    
}

extension ListSamplesViewController : ListSamplesScreenProtocol {}
