//
//  AddingDataDraw.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 2.11.21.
//

import UIKit
import Dip

class AddingDataDraw : UIView {
    
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
        button.setImage(UIImage(systemName: Style.plusSquare.rawValue,withConfiguration: largeConfig), for: .normal)
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
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50,weight: .bold, scale: .large)
        image.image = UIImage(systemName: Style.photo.rawValue,withConfiguration: largeConfig)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 3.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.colorButton.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.height / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imagePicker: UIImagePickerController = {
        let imagePick = UIImagePickerController()
        return imagePick
    }()
    
    //MARK: - MiddleView
    var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextField(placeholder: TextFieldLabel.enterFirstName.rawValue)
        textField.underLine()
        return textField
    }()
    
    var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextField(placeholder: TextFieldLabel.enterLastName.rawValue)
        textField.underLine()
        return textField
    }()
    
    var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextField(placeholder: TextFieldLabel.aboutSelf.rawValue)
        textField.underLine()
        return textField
    }()
    
    var radioLabel: UILabel = {
        let label = UILabel()
        label.text = Gender.chooseGender.rawValue
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var radioMale: UIButton = {
        let button = UIButton()
        button.radioButton(title: Gender.male.rawValue)
        return button
    }()
    
    var radioFemale: UIButton = {
        let button = UIButton()
        button.radioButton(title: Gender.female.rawValue)
        return button
    }()
    
    var radioUndefined: UIButton = {
        let button = UIButton()
        button.radioButton(title: Gender.undf.rawValue)
        return button
    }()
 
    //MARK: - BottomView
    var buttonAddInformation: UIButton = {
        let button = UIButton()
        button.coraleButton(title: Titles.add.rawValue)
        return button
    }()
    
    func viewCompare(view: UIView) {
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
            firstNameTextField.widthAnchor.constraint(equalTo: middleView.widthAnchor,constant: -20),
            lastNameTextField.widthAnchor.constraint(equalTo: middleView.widthAnchor,constant: -20),
            descriptionTextField.widthAnchor.constraint(equalTo: middleView.widthAnchor,constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            stackViewTop.topAnchor.constraint(equalTo: topView.topAnchor),
            stackViewTop.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            stackViewTop.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            stackViewTop.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            buttonAddImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: buttonAddImage.topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageView.frame.size.width),
            
            
        ])
        
        NSLayoutConstraint.activate([
            buttonAddInformation.widthAnchor.constraint(equalTo: bottomView.widthAnchor),
            buttonAddInformation.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
