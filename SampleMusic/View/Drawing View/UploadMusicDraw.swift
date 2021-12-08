//
//  UploadMusicDraw.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 15.11.21.
//

import UIKit
import MediaPlayer


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
        image.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imageLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(UploadKeys.uplImg.rawValue, comment: "")
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
        label.text = NSLocalizedString(UploadKeys.sampleName.rawValue, comment: "")
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sampleTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextField(placeholder: NSLocalizedString(UploadKeys.typeName.rawValue, comment: ""))
        textField.textAlignment = .left
        textField.underLine()
        return textField
    }()

    
    var uploadLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString(UploadKeys.chooseSample.rawValue, comment: "")
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
    
    var mediaPicker: UIDocumentPickerViewController = {
        var picker = UIDocumentPickerViewController(documentTypes: ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item","public.data", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content", "public.text"], in: .import)
        return picker
    }()
    
    //MARK: - BottomView
    
    var buttonAddInformation: UIButton = {
        let button = UIButton()
        button.coraleButton(title: NSLocalizedString(AddDataKeys.add.rawValue, comment: ""))
        return button
    }()
    
    //MARK: - Constraints
    func viewCompare(view: UIView) {
        view.addSubview(stackView)
        topView.addSubview(imageLabel)
        topView.addSubview(imageView)
        topView.addSubview(buttonAddImage)
        middleView.addSubview(middleStackView)
        bottomView.addSubview(buttonAddInformation)
        middleView.addSubview(uploadLabel)
        middleView.addSubview(buttonAddMusic)
        
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
            middleStackView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 20),
            
            uploadLabel.topAnchor.constraint(equalTo: middleStackView.bottomAnchor,constant: 15),
            uploadLabel.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 20),
            
            buttonAddMusic.topAnchor.constraint(equalTo: uploadLabel.bottomAnchor),
            buttonAddMusic.centerXAnchor.constraint(equalTo: middleView.centerXAnchor),
            buttonAddMusic.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),

            
            buttonAddInformation.topAnchor.constraint(equalTo: bottomView.topAnchor,constant: 50),
            buttonAddInformation.heightAnchor.constraint(equalToConstant: 50),
            buttonAddInformation.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 20),
            buttonAddInformation.trailingAnchor.constraint(equalTo: middleView.trailingAnchor,constant: -20),
            
            sampleTextField.widthAnchor.constraint(equalTo: middleStackView.widthAnchor),
        ])
    }
}
