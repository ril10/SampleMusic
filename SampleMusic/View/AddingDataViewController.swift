//
//  AddingDataAboutUser.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 27.10.21.
//

import UIKit


class AddingDataViewController: UIViewController {
    var coordinator : MainCoordinator?
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var imageView: UIImageView = {
        let image = UIImageView()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50,weight: .bold, scale: .large)
        image.image = UIImage(systemName: "photo",withConfiguration: largeConfig)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - View
    override func loadView() {
        super.loadView()
        
        view = UIView()
        view.backgroundColor = .white
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
            stackViewTop.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            stackViewTop.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonAddInformation.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            buttonAddInformation.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
