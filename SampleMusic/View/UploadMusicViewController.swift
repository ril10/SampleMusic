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
    var coordinator : MainCoordinator?
    
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
                viewModel?.uploadSample(sample: audioUrl, text: drawView.sampleTextField.text!)
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
        viewModel!.uploadSampleImage(image: (drawView.imageView.image?.jpegData(compressionQuality: 0.25)!)!, text: drawView.sampleTextField.text!)
    }
    //MARK: - UITextFieldDelegate
    
    //MARK: - View
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
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
        self.hideKeyboardWhenTappedAround()
    }
    
}

extension UploadMusicViewController : UploadMusicProtocol { }
