//
//  SellerDetailDraw.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import UIKit

class SellerDetailDraw: UIView {
    
    //MARK: - MainView
    var scrollView: UIScrollView = {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth , height: screenHeight))
        scroll.contentSize = CGSize(width: screenWidth, height: screenHeight)
        scroll.isScrollEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    //MARK: - StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView,middleView,bottomView])
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var middleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameLabel,secondNameLabel,descriptionLabel,emailLabel,genderLabel])
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var middleStackData: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstNameData,secondNameData,descriptionData,emailData,genderData])
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var samplesStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [samplesLabel,addButton,createSampleButton])
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    //MARK: - View
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
    var imageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        image.image = UIImage(systemName: Icons.photo.rawValue)
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 3.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.colorButton.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    //MARK: - MiddleView
    var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.firstName.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var secondNameLabel: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.lastName.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.description.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var emailLabel: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.email.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var genderLabel: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.gender.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var firstNameData: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.firstName.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var secondNameData: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.lastName.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var descriptionData: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.description.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var emailData: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.email.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var genderData: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.gender.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - BottomView
    var samplesLabel: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.samples.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(UIImage(systemName: Icons.add.rawValue ,withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var createSampleButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(UIImage(systemName: Icons.mic.rawValue ,withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var sampleTable: UITableView = {
        let tableView = UITableView()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 400)
        return tableView
    }()
    
    //MARK: - Contstraints
    func viewCompare(view: UIView) {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        topView.addSubview(imageView)
        middleView.addSubview(middleStackView)
        middleView.addSubview(middleStackData)
        middleView.addSubview(samplesStack)
        bottomView.addSubview(sampleTable)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: scrollView.frame.size.height),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageView.frame.size.width),
            imageView.heightAnchor.constraint(equalToConstant: imageView.frame.size.height * 2),
        ])
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: stackView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: middleView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            middleStackView.topAnchor.constraint(equalTo: middleView.topAnchor),
            middleStackView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 15),
            middleStackView.bottomAnchor.constraint(equalTo: samplesStack.topAnchor),
            middleStackData.leadingAnchor.constraint(equalTo: middleStackView.trailingAnchor),
            samplesStack.leadingAnchor.constraint(equalTo: middleView.leadingAnchor,constant: 15),
            samplesStack.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),
            samplesStack.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            middleView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            middleView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            middleView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            middleView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            sampleTable.topAnchor.constraint(equalTo: bottomView.topAnchor),
            sampleTable.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            sampleTable.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            sampleTable.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: middleView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
        ])
            
    }
    
}
