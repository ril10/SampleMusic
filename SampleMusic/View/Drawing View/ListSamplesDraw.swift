//
//  ListSamplesDraw.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import UIKit

class ListSamplesDraw : UIView {
    
    //MARK: - StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchController.searchBar,segment,sampleTable])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var segment : UISegmentedControl = {
        let segmentControl = UISegmentedControl(items: ["By Name","Sample Length"])
        segmentControl.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        segmentControl.backgroundColor = UIColor(named: Style.colorButton.rawValue)
        return segmentControl
    }()
    
    lazy var searchController : UISearchController = {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search by Name"
        search.searchBar.sizeToFit()
        search.searchBar.searchBarStyle = .default
        search.searchBar.translatesAutoresizingMaskIntoConstraints = true
        return search
    }()
    
    var sampleTable : UITableView = {
        let tableView = UITableView()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return tableView
    }()
    
    //MARK: - Constraints
    
    func viewCompare(view: UIView) {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
