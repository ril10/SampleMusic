//
//  UploadMusic.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 15.11.21.
//

import UIKit
import Dip
import MobileCoreServices
import AVFoundation

class UploadMusicViewController : UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate {
    
    var viewModel : UploadMusicImp?
    var drawView = UploadMusicDraw()
    var coordinator : UploadMusicCoordinator?
    
    init(viewModel: UploadMusicImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PhotoPicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        drawView.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - MediaPicker
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        drawView.mediaPicker.modalPresentationStyle = .formSheet
        let url = urls.first
        if let u = url?.path {
            if let audioUrl = URL(string: "file://" + u) {
                if url == nil {
                    errorWithFields()
                } else {
                    viewModel?.uploadSample(sample: audioUrl, text: drawView.sampleTextField.text!)
                }
            }
        }
    }
    //MARK: - ActionButton
    @objc func addImage(sender: UIButton!) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            drawView.imagePicker.sourceType = .photoLibrary
            drawView.imagePicker.allowsEditing = true
            present(drawView.imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func addMusic(sender: UIButton!) {
        self.present(drawView.mediaPicker, animated: true, completion: nil)
    }
    
    @objc func addInformation(sender: UIButton!) {
        if drawView.sampleTextField.text!.isEmpty || drawView.imageView.image == nil || viewModel?.isType == false {
            errorWithFields()
        } else {
            loadAlertView()
            viewModel!.uploadSampleImage(image: (drawView.imageView.image?.jpegData(compressionQuality: 0.25)!)!, text: drawView.sampleTextField.text!)
            viewModel!.addSampleName(text: drawView.sampleTextField.text!)
            viewModel!.addSampleCost(text: drawView.costTextField.text!)
        }
    }
    
    @objc func selectFree(sender: UIButton!) {
        viewModel?.isType = true
        viewModel?.typeSet(Collection.free.getCollection())
        if drawView.radioFree.currentImage == UIImage(systemName: Icons.radioOff.rawValue) {
            drawView.radioFree.setImage(UIImage(systemName: Icons.radioOn.rawValue), for: .normal)
            drawView.radioFree.tintColor = UIColor.black
            drawView.costTextField.isHidden = true
            drawView.radioPaid.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioPaid.tintColor = UIColor.white
        }
    }
    
    @objc func selectPaid(sender: UIButton!) {
        viewModel?.isType = true
        viewModel?.typeSet(Collection.paid.getCollection())
        if drawView.radioPaid.currentImage == UIImage(systemName: Icons.radioOff.rawValue) {
            drawView.radioPaid.setImage(UIImage(systemName: Icons.radioOn.rawValue), for: .normal)
            drawView.radioPaid.tintColor = UIColor.black
            drawView.costTextField.isHidden = false
            drawView.radioFree.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioFree.tintColor = UIColor.white
        }
    }
    //MARK: - Alert
    func errorWithFields() {
        let alertTitle = NSLocalizedString(ErrorKeys.eData.rawValue, comment: "")
        let okTitle = NSLocalizedString(MainKeys.ok.rawValue, comment: "")
        let fieldTitle = NSLocalizedString(ErrorKeys.eField.rawValue, comment: "")
        let alert = UIAlertController(title: alertTitle, message: fieldTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadAlertView() {
        let alertTitle = NSLocalizedString(MainKeys.loading.rawValue, comment: "")
        let waitTitle = NSLocalizedString(MainKeys.wait.rawValue, comment: "")
        let alert = UIAlertController(title: alertTitle, message: waitTitle, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating();
        viewModel?.loading = { load in
            if load {
                loadingIndicator.stopAnimating()
                loadingIndicator.hidesWhenStopped = true
                self.dismiss(animated: true, completion: nil)
                self.coordinator?.finish()
                self.textFieldShouldClear(self.drawView.sampleTextField)
                self.drawView.imageView.image = UIImage(systemName: Icons.photo.rawValue)
                
            }
        }
        alert.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor),
        ])
        self.present(alert, animated: true)
    }
    

    //MARK: - UITextFieldDelegate
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.text?.removeAll()
        return true
    }
    //MARK: - View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawView.costTextField.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor(named: Style.backgroundColor.rawValue)
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.imagePicker.delegate = self
        drawView.mediaPicker.delegate = self
        viewModel?.reloadView = { [weak self] in
            self?.view.setNeedsDisplay()
        }
        drawView.buttonAddImage.addTarget(self, action: #selector(addImage(sender:)), for: .touchUpInside)
        drawView.buttonAddMusic.addTarget(self, action: #selector(addMusic(sender:)), for: .touchUpInside)
        drawView.buttonAddInformation.addTarget(self, action: #selector(addInformation(sender:)), for: .touchUpInside)
        drawView.radioFree.addTarget(self, action: #selector(selectFree(sender:)), for: .touchUpInside)
        drawView.radioPaid.addTarget(self, action: #selector(selectPaid(sender:)), for: .touchUpInside)
        self.hideKeyboardWhenTappedAround()
    }
    
}

extension UploadMusicViewController : UploadMusicProtocol { }
