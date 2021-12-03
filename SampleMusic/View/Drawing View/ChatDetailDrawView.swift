//
//  ChatDetailDrawView.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit


class ChatDetailDrawView : UIView {
    
    //MARK: - StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sampleTable])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [messageTextField,sendMessage])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var sampleTable : UITableView = {
        let tableView = UITableView()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        tableView.separatorStyle = .none
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return tableView
    }()
    
    var messageTextField : UITextField = {
        let widthText = UIScreen.main.bounds.width
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: widthText, height: 0))
        textField.placeholder = "Write a message"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.default
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var sendMessage : UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "paperplane",withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor.darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Constraints
    
    func viewCompare(view: UIView) {
        view.addSubview(stackView)
        view.addSubview(messageTextField)
        view.addSubview(sendMessage)
        view.backgroundColor = UIColor(cgColor: UIColor(named: Style.coralColor.rawValue)!.cgColor)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: messageTextField.topAnchor,constant: -15),
            
            messageTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            messageTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 15),
            messageTextField.widthAnchor.constraint(equalTo: view.widthAnchor,constant: view.frame.size.width - 80),
           
            sendMessage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -15),
            sendMessage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -15),
            sendMessage.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor,constant: 10),
        ])
    }
    
}
