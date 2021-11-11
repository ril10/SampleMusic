//
//  AddingDataAboutUser.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 27.10.21.
//

import UIKit
import Dip

class AddingDataViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    var coordinator : MainCoordinator?
    var viewModel : AddingDataImp?
    var drawView = AddingDataDraw()

    
    init(viewModel: AddingDataImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - PickerAction
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        drawView.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
  
    //MARK: - ButtonAction
    @objc func addImageAction(sender: UIButton!) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            drawView.imagePicker.sourceType = .photoLibrary
            drawView.imagePicker.allowsEditing = true
            present(drawView.imagePicker, animated: true, completion: nil)
        }
    }
    @objc func maleSelect(sender: UIButton!) {
        viewModel?.genderSet(gender: Gender.male.rawValue)
        if drawView.radioMale.currentImage == UIImage(systemName: Icons.radioOff.rawValue) {
            drawView.radioMale.setImage(UIImage(systemName: Icons.radioOn.rawValue), for: .normal)
            drawView.radioMale.tintColor = UIColor.black
            drawView.radioFemale.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioFemale.tintColor = UIColor.white
            drawView.radioUndefined.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioUndefined.tintColor = UIColor.white
        }
    }
    
    @objc func femaleSelect(sender: UIButton!) {
        viewModel?.genderSet(gender: Gender.female.rawValue)
        if drawView.radioFemale.currentImage == UIImage(systemName: Icons.radioOff.rawValue) {
            drawView.radioFemale.setImage(UIImage(systemName: Icons.radioOn.rawValue), for: .normal)
            drawView.radioFemale.tintColor = UIColor.black
            drawView.radioMale.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioMale.tintColor = UIColor.white
            drawView.radioUndefined.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioUndefined.tintColor = UIColor.white
        }
    }
    
    @objc func undefSelect(sender: UIButton!) {
        viewModel?.genderSet(gender: Gender.undf.rawValue)
        if drawView.radioUndefined.currentImage == UIImage(systemName: Icons.radioOff.rawValue) {
            drawView.radioUndefined.setImage(UIImage(systemName: Icons.radioOn.rawValue), for: .normal)
            drawView.radioUndefined.tintColor = UIColor.black
            drawView.radioMale.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioMale.tintColor = UIColor.white
            drawView.radioFemale.setImage(UIImage(systemName: Icons.radioOff.rawValue), for: .normal)
            drawView.radioFemale.tintColor = UIColor.white
        }
    }
   
    @objc func addToFirebase(sender: UIButton!) {
        if drawView.firstNameTextField.text!.isEmpty || drawView.lastNameTextField.text!.isEmpty || drawView.descriptionTextField.text!.isEmpty || drawView.imageView.image == nil || viewModel?.gender == nil {
            errorWithFields()
        } else {
            loadAlertView()
            viewModel?.currentUser(firstName: drawView.firstNameTextField.text!, lastName: drawView.lastNameTextField.text!, description: drawView.descriptionTextField.text!)
            viewModel?.uploadImage(image: (drawView.imageView.image?.pngData()!)!)
        }
    }
    //MARK: - Alert
    func errorWithFields() {
        let alert = UIAlertController(title: AlertTitle.errorAddingData.rawValue, message: TextFieldLabel.allFields.rawValue, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Titles.ok.rawValue, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func loadAlertView() {
        let alert = UIAlertController(title: AlertTitle.loading.rawValue, message: AlertTitle.wait.rawValue, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating();
        viewModel?.loading = { load in
            if load {
                loadingIndicator.stopAnimating()
                loadingIndicator.hidesWhenStopped = true
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor),
        ])
        self.present(alert, animated: true)
    }
    //MARK: - View
    
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        drawView.viewCompare(view: view)
        drawView.buttonAddImage.addTarget(self, action: #selector(addImageAction(sender:)), for: .touchUpInside)
        drawView.radioMale.addTarget(self, action: #selector(maleSelect(sender:)), for: .touchUpInside)
        drawView.radioFemale.addTarget(self, action: #selector(femaleSelect(sender:)), for: .touchUpInside)
        drawView.radioUndefined.addTarget(self, action: #selector(undefSelect(sender:)), for: .touchUpInside)
        drawView.buttonAddInformation.addTarget(self, action: #selector(addToFirebase(sender:)), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.firstNameTextField.delegate = self
        drawView.lastNameTextField.delegate = self
        drawView.descriptionTextField.delegate = self
        drawView.imagePicker.delegate = self
        viewModel?.reloadView = { [weak self] in
            self?.view.setNeedsDisplay()
        }
        viewModel?.navUser = { nav in
            if nav {
                self.coordinator?.userList()
            }
        }
        viewModel?.navSeller = { nav in
            if nav {
                self.coordinator?.mainTabController()
            }
        }
        self.hideKeyboardWhenTappedAround()
    }
    deinit {
        print("deinit Adding Data deinit")
    }
}
extension AddingDataViewController : AddingDataScreenProtocol {}
