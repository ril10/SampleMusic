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
import FirebaseStorageUI

class ListSampleViewModel: ListSamplesImp {

    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var image : UIImage?
    var dismissAlert: ((Bool) -> Void)?
    
    var samplesData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    init (db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    func getSamplesData() {
            db?.collection(Role.sample.rawValue.lowercased())
                .getDocuments(completion: { ( query, error ) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        var resData = [SampleModel]()
                        for document in query!.documents {
                            let sampleData = SampleModel(data: document.data())
                            resData.append(sampleData)
                        }
                        self.fetchData(res: resData)
                    }
                })
    }
    
    func fetchData(res: [SampleModel]) {
        var resData = [DataCellModel]()
        for r in res {
            resData.append(createCellModel(cell: r))
        }
        samplesData = resData

    }
    
    func createCellModel(cell: SampleModel) -> DataCellModel {
        let sampleName = cell.sampleName
        let imageView = UIImageView()
        var imageArray = [String]()
        imageArray.append(cell.sampleImageUrl)
        for img in imageArray {
            imageView.sd_setImage(with: (self.st?.reference(forURL: img))!)
        }

        
//            let storRefrence = self.st?.reference(forURL: cell.sampleUrl)
//            storRefrence?.getData(maxSize: 3 * 1024 * 1024, completion: { data, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                } else {
//
//                }
//            })
        
        return DataCellModel(imageSample: ((imageView.image) ?? UIImage(systemName: Icons.photo.rawValue))!, sampleName: sampleName, sampleData: "")
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
