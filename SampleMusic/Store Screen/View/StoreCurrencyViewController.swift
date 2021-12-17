//
//  StoreCurrencyViewController.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 16.12.21.
//

import UIKit

class StoreCurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel : StoreImp
    var drawView = StoreCurrencyDraw()
    var coordinator : StoreCurrencyCoordinator?
    
    var currentTableAnimation: TableAnimation = .moveUpWithFade(rowHeight: 140, duration: 0.85, delay: 0.05)
    var storeView: CustomViewAnimation = .fadeIn(duration: 0.85, delayFactor: 0.05)
    
    init(viewModel: StoreImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.storeDeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.storeCell.rawValue ,for: indexPath) as! StoreCell
        let cellVm = viewModel.getCellModel(at: indexPath)
        cell.storeCell = cellVm

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimation(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    //MARK: - View
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
        let animation = storeView.getAnimation()
        let animator = AnimatedView(animation: animation)
        animator.animate(view: drawView.storeViewTop)
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = UIColor(named: Style.backgroundColor.rawValue)
        drawView.viewCompare(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawView.sampleTable.register(StoreCell.self, forCellReuseIdentifier: TableCell.storeCell.rawValue)
        drawView.sampleTable.dataSource = self
        drawView.sampleTable.delegate = self
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.drawView.sampleTable.reloadData()
            }
        }

    }
    

}

extension StoreCurrencyViewController: StoreCurrencyProtocol {}
