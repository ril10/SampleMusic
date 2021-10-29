//
//  SellerDetailViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 27.10.21.
//

import UIKit

class SellerDetailViewController: UIViewController,UITableViewDelegate {
    
    var coordinator : MainCoordinator?
    
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
    
//    var tabBar: = {
//        let bottomBar = UITabBarController()
//
//        return bottomBar
//    }()
    //MARK: - StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView,middleView,bottomView])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
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
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 50,weight: .bold, scale: .large)
        image.image = UIImage(systemName: Style.photo.rawValue,withConfiguration: largeConfig)
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
    //MARK: - BottomView
    var samplesLabel: UILabel = {
        let label = UILabel()
        label.text = TitleDetail.samples.rawValue
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 20.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var sampleTable: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    //MARK: - Contstraints
    func viewCompare() {
        //        view.addSubview(scrollView)
        view.addSubview(stackView)
        stackView.addSubview(imageView)
        stackView.addSubview(middleStackView)
        stackView.addSubview(samplesLabel)
//        view.addSubview(tabBar)
        //        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topView.topAnchor,constant: 15),
            imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor,constant: 30),
            imageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor,constant: -30),
            imageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor,constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            middleStackView.topAnchor.constraint(equalTo: middleView.topAnchor),
            middleStackView.leadingAnchor.constraint(equalTo: middleView.leadingAnchor),
            middleStackView.trailingAnchor.constraint(equalTo: middleView.trailingAnchor),
            middleStackView.bottomAnchor.constraint(equalTo: middleView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            samplesLabel.topAnchor.constraint(equalTo: bottomView.topAnchor),
            samplesLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor)
        ])
    }
    //MARK: - View
    override func loadView() {
        super.loadView()
        configureNavBar()
        view = UIView()
        view.backgroundColor = .white
        viewCompare()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        let textFieldCell = UINib(nibName: "CustomCell", bundle: nil)
        self.sampleTable.register(textFieldCell, forCellReuseIdentifier: "CustomCell")
    }
    
    func configureNavBar() {
        let nav = self.navigationController?.navigationBar
        
        nav?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(named: Style.colorButton.rawValue) as Any,
            NSAttributedString.Key.font: UIFont(name: Style.fontTitleHeavy.rawValue, size: 18) as Any
        ]
        
        nav?.isTranslucent = true
        nav?.topItem?.title = "Seller Detail"
        nav?.barTintColor = .white
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.layoutIfNeeded()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    
}
