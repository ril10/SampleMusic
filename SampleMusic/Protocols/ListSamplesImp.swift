//
//  ListSamplesImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.11.21.
//

import Foundation

protocol ListSamplesImp {
    var reloadTableView : (() -> Void)? { get set }
    func logout()
    func getSamplesData()
    var samplesData : [DataCellModel] { get set }
    func getCellModel(at indexPath: IndexPath) -> DataCellModel
    var dismissAlert : ((Bool) -> Void)? { get set }
    func filterByName()
    func filterByTrackLength()
    func searchResults(text: String)
    func getSearchData()
    func signUser()
    var hide : ((Bool) -> Void)? { get set }
    func hideUserDetail()
    var chatRoom : String? { get set }
    var curUser : String? { get set }
    func filterByPrice()
}
