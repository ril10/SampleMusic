//
//  StoreCurrencyDraw.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 16.12.21.
//

import UIKit

class StoreCurrencyDraw {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [storeViewTop,sampleTable])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var storeViewTop: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Style.coralColor.rawValue)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    var storeLabel: UILabel = {
        let label = UILabel()
        label.text = "Check our awesome deals!"//NSLocalizedString(UploadKeys.uplImg.rawValue, comment: "")
        label.font = UIFont(name: Style.fontTitleHeavy.rawValue, size: 25.0)
        label.tintColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func viewCompare(view: UIView) {
        view.addSubview(stackView)
        storeViewTop.addSubview(storeLabel)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            storeViewTop.heightAnchor.constraint(equalToConstant: 150),
            storeLabel.centerXAnchor.constraint(equalTo: storeViewTop.centerXAnchor),
            storeLabel.centerYAnchor.constraint(equalTo: storeViewTop.centerYAnchor),
        ])

    }
}
