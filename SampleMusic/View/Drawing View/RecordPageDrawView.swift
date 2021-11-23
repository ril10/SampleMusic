//
//  RecordPaveDrawView.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import UIKit


class RecordPageDrawView : UIView {
    //MARK: - StackView

    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sampleNameLabel,sampleTextField,uploadLabel,createMusic])
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    //MARK: - TopView
    var uploadLabel: UILabel = {
        let label = UILabel()
        label.text = "2.Create your sample"
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - MiddleView
    var sampleNameLabel: UILabel = {
        let label = UILabel()
        label.text = "1.Type sample name:"
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sampleTextField: UITextField = {
        let textField = UITextField()
        textField.defaultTextField(placeholder: TextFieldLabel.sampleName.rawValue)
        textField.textAlignment = .left
        textField.underLine()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    var createMusic: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: Icons.mic.rawValue,withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var recordLabel: UILabel = {
        let label = UILabel()
        label.text = "Recoding..."
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.textColor = UIColor(named: Style.colorButton.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - BottomView
    
    //MARK: - Constraints
    func viewCompare(view: UIView) {
        view.addSubview(stackView)
        
        view.addSubview(recordLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            createMusic.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            recordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordLabel.topAnchor.constraint(equalTo: createMusic.bottomAnchor),
        ])
    }
    
}
