//
//  AddingDataAboutUser.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 27.10.21.
//

import UIKit


class AddingDataViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    init(viewModel: AddingDataAboutUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var coordinator : MainCoordinator?
    var viewModel : AddingDataAboutUserViewModel!
    //MARK: - StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView,middleView,bottomView])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewTop: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView,buttonAddImage])
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewMiddle: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField,lastNameTextField,descriptionTextField,radioLabel,stackRadio])
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackRadio: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [radioMale,radioFemale,radioUndefined])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - ViewUnderStack
    var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var middleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - TopView
    var buttonAddImage: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "plus.square",withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 10
        button.addTarget(self, action: #selector(addImageAction(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50,weight: .bold, scale: .large)
        image.image = UIImage(systemName: "photo",withConfiguration: largeConfig)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 3.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: "mainScreenRed")?.cgColor
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imagePicker: UIImagePickerController = {
        let imagePick = UIImagePickerController()
        
        return imagePick
    }()
    
    @objc func addImageAction(sender: UIButton!) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - MiddleView
    var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your First Name"
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.underLine()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your Last Name"
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.underLine()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type about your self"
        textField.borderStyle = UITextField.BorderStyle.none
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.underLine()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var radioLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your gender*"
        label.font = UIFont(name: "Avenir Light", size: 15.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var radioMale: UIButton = {
        let button = UIButton()
        button.setTitle("Male", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.tintColor = UIColor.black
        button.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 15)
        button.addTarget(self, action: #selector(maleSelect(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var radioFemale: UIButton = {
        let button = UIButton()
        button.setTitle("Female", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 15)
        button.tintColor = UIColor.black
        button.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        button.addTarget(self, action: #selector(femaleSelect(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var radioUndefined: UIButton = {
        let button = UIButton()
        button.setTitle("Undefined", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Heavy", size: 15)
        button.tintColor = UIColor.black
        button.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        button.addTarget(self, action: #selector(undefSelect(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func maleSelect(sender: UIButton!) {
        viewModel.genderSet(gender: "Male")
        if radioMale.currentImage == UIImage(systemName: "smallcircle.circle") {
            radioMale.setImage(UIImage(systemName: "smallcircle.fill.circle"), for: .normal)
            radioFemale.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
            radioUndefined.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        }
    }
    
    @objc func femaleSelect(sender: UIButton!) {
        viewModel.genderSet(gender: "Female")
        if radioFemale.currentImage == UIImage(systemName: "smallcircle.circle") {
            radioFemale.setImage(UIImage(systemName: "smallcircle.fill.circle"), for: .normal)
            radioMale.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
            radioUndefined.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        }
    }
    
    @objc func undefSelect(sender: UIButton!) {
        viewModel.genderSet(gender: "Undefined")
        if radioUndefined.currentImage == UIImage(systemName: "smallcircle.circle") {
            radioUndefined.setImage(UIImage(systemName: "smallcircle.fill.circle"), for: .normal)
            radioMale.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
            radioFemale.setImage(UIImage(systemName: "smallcircle.circle"), for: .normal)
        }
    }
    //MARK: - BottomView
    var buttonAddInformation: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "mainScreenRed")
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 10
        button.addTarget(self, action: #selector(addToFirebase(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func addToFirebase(sender: UIButton!) {
        viewModel.currentUser(firstName: firstNameTextField.text!, LastName: lastNameTextField.text!, description: descriptionTextField.text!)
    }
    //MARK: - View
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        descriptionTextField.delegate = self
        imagePicker.delegate = self
        viewModel.reloadView = { [weak self] in
            self?.view.setNeedsDisplay()
        }
        viewCompare()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    func viewCompare() {
        view.addSubview(stackView)
        stackView.addSubview(stackViewTop)
        stackView.addSubview(stackViewMiddle)
        bottomView.addSubview(buttonAddInformation)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -40),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -40),
        ])
        
        NSLayoutConstraint.activate([
            buttonAddInformation.topAnchor.constraint(equalTo: bottomView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewMiddle.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            stackViewMiddle.topAnchor.constraint(equalTo: middleView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewTop.topAnchor.constraint(equalTo: topView.topAnchor),
            stackViewTop.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            stackViewTop.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            stackViewTop.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            buttonAddImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant: stackViewTop.frame.size.width / 2),
//            imageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor,constant: stackViewTop.frame.size.width / 2),
            imageView.bottomAnchor.constraint(equalTo: buttonAddImage.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageView.frame.size.width),
            
            
        ])
        
        NSLayoutConstraint.activate([
            buttonAddInformation.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            buttonAddInformation.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
