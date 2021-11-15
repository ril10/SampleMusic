//
//  UploadMusicDraw.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 15.11.21.
//

import UIKit


class UploadMusicDraw : UIView {
    //MARK: - StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView,middleView,bottomView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var middleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sampleNameLabel,sampleTextField])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var musicStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [uploadLabel,buttonAddMusic])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Views
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
        button.setImage(UIImage(systemName: Icons.plusSquare.rawValue,withConfiguration: largeConfig), for: .normal)
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
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        image.image = UIImage(systemName: Icons.photo.rawValue)
        image.contentMode = .scaleToFill
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 3.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.colorButton.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imageLabel: UILabel = {
        let label = UILabel()
        label.text = "1.Upload image for sample"
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imagePicker: UIImagePickerController = {
        let imagePick = UIImagePickerController()
        return imagePick
    }()
    
    //MARK: - MiddleView
    var sampleNameLabel: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.sampleName.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sampleTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextField(placeholder: TextFieldLabel.sampleName.rawValue)
        textField.textAlignment = .center
        textField.underLine()
        return textField
    }()
    
    var buttonAddInformation: UIButton = {
        let button = UIButton()
        button.coraleButton(title: Titles.add.rawValue)
        return button
    }()
    
    var uploadLabel: UILabel = {
        let label = UILabel()
        label.text = "3.Choose sample to upload"
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonAddMusic: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: Icons.plusSquare.rawValue,withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Constraints
    func viewCompare(view: UIView) {
        view.addSubview(stackView)
        topView.addSubview(imageLabel)
        topView.addSubview(imageView)
        topView.addSubview(buttonAddImage)
        middleView.addSubview(middleStackView)
        middleView.addSubview(buttonAddInformation)
        middleView.addSubview(musicStackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: topView.topAnchor),
            imageLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant: 20),
            imageLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: imageLabel.bottomAnchor),
            imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageView.frame.size.width),
            imageView.heightAnchor.constraint(equalToConstant: imageView.frame.size.height * 2),
            buttonAddImage.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            buttonAddImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            buttonAddImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            buttonAddImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
        ])
        
        
        NSLayoutConstraint.activate([
            middleStackView.topAnchor.constraint(equalTo: middleView.topAnchor),
            middleStackView.bottomAnchor.constraint(equalTo: musicStackView.topAnchor,constant: -15),
            middleStackView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 20),
        
            musicStackView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 20),
            musicStackView.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),
            musicStackView.bottomAnchor.constraint(equalTo: buttonAddInformation.topAnchor,constant: -30),
            
            buttonAddInformation.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
            buttonAddInformation.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 20),
            buttonAddInformation.trailingAnchor.constraint(equalTo: middleView.trailingAnchor,constant: -20),
            
        ])
    }
}