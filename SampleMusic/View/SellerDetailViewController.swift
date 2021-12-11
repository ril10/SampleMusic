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
    
    var coordinator : SellerDetailCoordinator?
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
    
    @objc func message(sender: UIButton) {
        viewModel.checkChatRoom(ownerUid: viewModel.currentUserUid(), recieverUid: viewModel.ownerUid ?? "")
        viewModel.isValid = { valid in
            if valid == false {
                self.viewModel.createChatRoom(ownerUid: self.viewModel.currentUserUid(), recieverUid: self.viewModel.ownerUid ?? "")
            }
        }
        viewModel.goToChat = { room in
            self.coordinator?.writeMessage(chatRoom: room)
        }
        
    }
    
    @objc func sortSampleTable(sender: UIButton) {
        if drawView.sampleTable.isEditing {
            drawView.sampleTable.isEditing = false
            drawView.sortButton.setImage(UIImage(systemName: Icons.sort.rawValue), for: .normal)
        } else {
            drawView.sampleTable.isEditing = true
            drawView.sortButton.setImage(UIImage(systemName: Icons.check.rawValue), for: .normal)
        }
    }
    //MARK: - Alert
    func alertLoading() {
        let alertTitile = NSLocalizedString(MainKeys.loading.rawValue, comment: "")
        let waitTitle = NSLocalizedString(MainKeys.wait.rawValue, comment: "")
        let alert = UIAlertController(title: alertTitile, message: waitTitle, preferredStyle: .alert)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cell.rawValue,for: indexPath) as! CustomTableViewCell
        let cellVm = self.viewModel.getCellModel(at: indexPath)
        cell.sampleCell = cellVm
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cellVm = self.viewModel.getCellModel(at: indexPath)
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.viewModel.deleteSample(by: cellVm.sampleName)
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = viewModel.samplesData[sourceIndexPath.row]
        viewModel.samplesData.remove(at: sourceIndexPath.row)
        viewModel.samplesData.insert(itemToMove, at: destinationIndexPath.row)
        
        for (index, element) in viewModel.samplesData.enumerated() {
            viewModel.getSampleIndex(start: index, destination: element.index)
        }

    }
    

    
    //MARK: - View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.ownerUid != nil {
            self.viewModel.getDataFromUser(ownerUid: viewModel.ownerUid!)
            self.viewModel.getDataSamplesFromUser(ownerUid: viewModel.ownerUid!)
            self.drawView.addButton.isHidden = true
            self.drawView.createSampleButton.isHidden = true
            self.drawView.sortButton.isHidden = true
            configureNavBar()
        }
        if viewModel.currentUserUid() == viewModel.currentUserUid() {
            if viewModel.samplesData.count == 0 {
                self.alertLoading()
                self.viewModel?.getSamplesData()
                viewModel?.userData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor(named: Style.backgroundColor.rawValue)
        drawView.viewCompare(view: view)
        drawView.sortButton.addTarget(self, action: #selector(sortSampleTable(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawView.sampleTable.register(CustomTableViewCell.self, forCellReuseIdentifier: TableCell.cell.rawValue)
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.drawView.sampleTable.reloadData()
            }
        }
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
        
        

    }
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.coralColor.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        nav?.isTranslucent = true
        nav?.barTintColor = .white
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        let sendTitle = NSLocalizedString(ChatKeys.sendMess.rawValue, comment: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: sendTitle, style: .plain, target: self, action: #selector(message(sender:)))
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
}
extension SellerDetailViewController : SellerScreenProtocol {}
