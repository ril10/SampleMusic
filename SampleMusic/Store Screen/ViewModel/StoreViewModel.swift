//
//  StoreViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 16.12.21.
//

import Foundation
import FirebaseFirestore

class StoreViewModel: StoreImp {
    
    var db: Firestore
    init(db: Firestore) {
        self.db = db
    }
    
    var reloadTableView: (() -> Void)?
    
    var storeDeals = [StoreCellModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    //MARK: - Get Data
    func getData() {
        self.db.collection(Collection.store.getCollection())
            .addSnapshotListener({ querySnapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    var resData = [StoreModel]()
                    for document in querySnapshot!.documents {
                        let messageData = StoreModel(data: document.data())
                        resData.append(messageData)
                    }
                    self.fetchData(res: resData)
                }
            })
    }

    

    //MARK: - Fetch Data
    func fetchData(res: [StoreModel]) {
        var resData = [StoreCellModel]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        storeDeals = resData
    }
    
    //MARK: - Store Cell
    func createCellModel(cell: StoreModel) -> StoreCellModel {
        let name = cell.name
        let cost = cell.cost
        let image = cell.image
        
        return StoreCellModel(name: name ?? "", cost: cost ?? 0, image: image ?? "")
    }
    
    func getCellModel(at indexPath: IndexPath) -> StoreCellModel {
        return storeDeals[indexPath.row]
    }

    
    
    
    
}
