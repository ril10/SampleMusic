//
//  ListSampleViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import Dip
import UIKit

class ListSampleViewModel: ListSamplesImp {

    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?

    var samplesData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    init (db: Firestore,st: Storage) {
        self.db = db
    }
    
    func getSamplesData() {
        if let user = Auth.auth().currentUser {
            self.db?.collection(Role.sample.rawValue.lowercased()).document(user.uid).getDocument(completion: { document, error in
                if let data = document?.data() {
                    let sampleData = SampleModel(data: data)
                    self.fetchData(res: [sampleData])
                }
            })
        }
    }
    
    func fetchData(res: [SampleModel]) {
        var resData = [DataCellModel]()
        for r in res {
            resData.append(createCellModel(cell: r))
        }
        samplesData = resData

    }
    
    func createCellModel(cell: SampleModel) -> DataCellModel {
        var image : UIImage?
        var sampleName : String?

            let storageRefrence = self.st?.reference(forURL: cell.sampleImageUrl)
            storageRefrence?.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    image = UIImage(data: data!)
                }
            })
        
        

            let storRefrence = self.st?.reference(forURL: cell.sampleUrl)
            storRefrence?.getData(maxSize: 3 * 1024 * 1024, completion: { data, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print(data)
                }
            })
        

            sampleName = cell.sampleName
        
        
        return DataCellModel(imageSample: (UIImage(systemName: Icons.pause.rawValue)!), sampleName: sampleName!, sampleData: "")
    }
    
    func getCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesData[indexPath.row]
    }
    
    func logout() {
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
    }
    
}
