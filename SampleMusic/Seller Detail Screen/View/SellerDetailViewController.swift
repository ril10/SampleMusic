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
import SDWebImage

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
        viewModel.checkChatRoom(ownerUid: viewModel.currentUserUid(), recieverUid: viewModel.ownerUid ?? "") { check in
            if check {
                self.viewModel.createChatRoom(ownerUid: self.viewModel.currentUserUid(), recieverUid: self.viewModel.ownerUid ?? "")
            }
            return nil
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

    @objc func segmentAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            drawView.sampleTable.reloadData()
        case 1:
            drawView.sampleTable.reloadData()
        default:
            break
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
        if drawView.segmentControl.selectedSegmentIndex == 0 {
            return viewModel.samplesFreeData.count
        } else {
            return viewModel.samplesPaidData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.cell.rawValue,for: indexPath) as! CustomTableViewCell
        if drawView.segmentControl.selectedSegmentIndex == 0 {
            let cellVm = self.viewModel.getCellModel(at: indexPath)
            cell.sampleCell = cellVm
        } else {
            let cellPaidVm = self.viewModel.getPaidCellModel(at: indexPath)
            cell.sampleCell = cellPaidVm
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if drawView.segmentControl.selectedSegmentIndex == 0 {
            let cellVm = self.viewModel.getCellModel(at: indexPath)
            let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
                self?.viewModel.deleteSample(by: cellVm.sampleName)
                completionHandler(true)
            }
            delete.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [delete])
        } else {
            let cellVm = self.viewModel.getPaidCellModel(at: indexPath)
            let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
                self?.viewModel.deleteSample(by: cellVm.sampleName)
                completionHandler(true)
            }
            delete.backgroundColor = .systemRed
            return UISwipeActionsConfiguration(actions: [delete])
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if drawView.segmentControl.selectedSegmentIndex == 0 {
            let itemToMove = viewModel.samplesFreeData[sourceIndexPath.row]
            viewModel.samplesFreeData.remove(at: sourceIndexPath.row)
            viewModel.samplesFreeData.insert(itemToMove, at: destinationIndexPath.row)
            
            for (index, element) in viewModel.samplesFreeData.enumerated() {
                viewModel.getSampleIndex(start: index, destination: element.index)
            }
        } else {
            let itemToMove = viewModel.samplesPaidData[sourceIndexPath.row]
            viewModel.samplesPaidData.remove(at: sourceIndexPath.row)
            viewModel.samplesPaidData.insert(itemToMove, at: destinationIndexPath.row)
            
            for (index, element) in viewModel.samplesPaidData.enumerated() {
                viewModel.getSampleIndex(start: index, destination: element.index)
            }
        }


    }
    

    
    //MARK: - View
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.ownerUid != nil {
            self.viewModel.getDataFromUser(ownerUid: viewModel.ownerUid!)
            self.viewModel.getDataSamplesFromUser(ownerUid: viewModel.ownerUid!)
            self.viewModel.getPaidSamplesFromUserData(ownerUid: viewModel.ownerUid!)
            self.drawView.addButton.isHidden = true
            self.drawView.createSampleButton.isHidden = true
            self.drawView.sortButton.isHidden = true
            configureNavBar()
        }
        if viewModel.currentUserUid() == viewModel.currentUserUid() {
            if viewModel.samplesFreeData.count == 0 {
                self.viewModel?.getSamplesData()
                self.viewModel?.getPaidSamplesData()
                viewModel?.userData()
//                self.alertLoading()
            } else if viewModel.samplesPaidData.count == 0 {
                self.viewModel?.getPaidSamplesData()
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
        drawView.segmentControl.selectedSegmentIndex = 0
        drawView.segmentControl.addTarget(self, action: #selector(ListSamplesViewController.segmentAction(sender:)), for: .valueChanged)
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

        viewModel.fieldData = { [weak self] firstName,lastName,desc,email,gender,image in
            self?.drawView.firstNameData.text = firstName
            self?.drawView.secondNameData.text = lastName
            self?.drawView.descriptionData.text = desc
            self?.drawView.emailData.text = email
            self?.drawView.genderData.text = gender
            self?.drawView.imageView.sd_setImage(with: URL(string: image), placeholderImage: UIImage(systemName: Icons.photo.rawValue))
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