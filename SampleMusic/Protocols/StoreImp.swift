//
//  StoreImp.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 16.12.21.
//

import Foundation
import FirebaseFirestore


protocol StoreImp {
    var reloadTableView : (() -> Void)? { get set }
    var db : Firestore { get set }
    func getData()
    var storeDeals : [StoreCellModel] { get set }
    func getCellModel(at indexPath: IndexPath) -> StoreCellModel
}
