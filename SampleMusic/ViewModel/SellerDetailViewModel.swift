//
//  SellerDetailViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.10.21.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import Dip
import UIKit



class SellerDetailViewModel: SellerImp {

    var reloadView : (() -> Void)?
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var image: ((Data) -> Void)?
    var dismissAlert: ((Bool) -> Void)?
    var fieldData : ((String,String,String,String,String) -> Void)?
    var sampleImage : UIImage?
    var sampleData : String?

    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    var samplesData = [DataCellModel]() {
        didSet {
            reloadView?()
            reloadTableView?()
        }
    }
    
    func userData() {
        if let user = Auth.auth().currentUser {
                self.db?.collection(Role.seller.rawValue.lowercased()).document(user.uid).getDocument(completion: { (document, error) in
                    if let data = document?.data() {
                        let sellerData = DetailModel(data: data)
                        let imgRef = self.st?.reference(forURL: sellerData.imageUrl)
                        imgRef?.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                self.image?(data!)
                                self.dismissAlert?(true)
                            }
                        })
                            self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender)
                    }
                })
            }
    }
    

    
    func getSamplesData() {
        if let user = Auth.auth().currentUser {
            let refrence = db?.collection(Role.sample.rawValue.lowercased())
            refrence?.whereField("ownerUid", isEqualTo: user.uid)
                .getDocuments(completion: { query, error in
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
    }
    
    func fetchData(res: [SampleModel]) {
        var resData = [DataCellModel]()
        for r in res {
            resData.append(createCellModel(cell: r))
        }
        samplesData = resData
    }
    
    func createCellModel(cell: SampleModel) -> DataCellModel {
        let name = cell.sampleName
        print(cell.sampleImageUrl)
        self.st?.reference(forURL: cell.sampleImageUrl)
            .getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.reloadTableView?()
                    self.sampleImage = UIImage(data: data!)
                }
            })

        self.st?.reference(forURL: cell.sampleUrl)
            .getData(maxSize: 3 * 1024 * 1024, completion: { data, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                   
                }
            })
        
        return DataCellModel(imageSample: sampleImage ?? (UIImage(systemName: Icons.photo.rawValue)!), sampleName: name, sampleData: "")
    }
    
    func getCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesData[indexPath.row]
    }

}
