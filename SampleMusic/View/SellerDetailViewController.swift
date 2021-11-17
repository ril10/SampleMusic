//
//  SellerDetailViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 27.10.21.
//

import UIKit
import Dip
import MediaPlayer
import AVFoundation

class SellerDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPMediaPickerControllerDelegate {

    var coordinator : UploadMusicCoordinator?
    var drawView = SellerDetailDraw()
    var viewModel : SellerImp!
    var mediaPicker : MPMediaPickerController?
    var mediaItems = [MPMediaItem]()
    
    init(viewModel: SellerImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ButtonAction
    @objc func editData(sender: UIButton!) {
        
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
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.samplesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell",for: indexPath) as! CustomTableViewCell
        let cellVm = viewModel.getCellModel(at: indexPath)
        cell.sampleCell = cellVm
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: - View

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alertLoading()
        viewModel?.userData()
        viewModel?.getSamplesData()
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
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
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.drawView.sampleTable.reloadData()
            }
        }
            
    }
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar

        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.colorButton.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]

        nav?.isTranslucent = true
        nav?.barTintColor = .white
        nav?.topItem!.title = "Seller Detail"
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editData(sender:)))
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
}
extension SellerDetailViewController : SellerScreenProtocol {}
