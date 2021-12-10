//
//  SellerImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 8.11.21.
//

import Foundation

protocol SellerImp {
    var reloadView : (() -> Void)? { get set }
    var fieldData : ((String,String,String,String,String) -> Void)? { get set }
    func userData()
    var image : ((Data) -> Void)? { get set }
    var reloadTableView : (() -> Void)? { get set }
    func getSamplesData()
    var samplesData : [DataCellModel] { get set }
    func getCellModel(at indexPath: IndexPath) -> DataCellModel
    var dismissAlert : ((Bool) -> Void)? { get set }
    var ownerUid : String? { get set }
    func getDataFromUser(ownerUid: String)
    func getDataSamplesFromUser(ownerUid: String)
    func currentUserUid() -> String
    func deleteSample(by name: String)
    func getSampleIndex(start index: Int, destination destIndex: Int)
    func createChatRoom(ownerUid: String, recieverUid: String)
}
