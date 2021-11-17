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



class SellerDetailViewModel: SellerImp {

    var reloadView : (() -> Void)?
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var image: ((Data) -> Void)?
    var dismissAlert: ((Bool) -> Void)?
    var fieldData : ((String,String,String,String,String) -> Void)?
    var sampleImage : UIImage?
    var sampleName : String?
    var sampleData : String?
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    var samplesData = [DataCellModel]() {
        didSet {
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
                            }
                        })
                            self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender)
                    }
                })
            }
    }
    

    
    func getSamplesData() {
        if let user = Auth.auth().currentUser {
            self.db?.collection(Role.sample.rawValue.lowercased()).document(user.uid).getDocument(completion: { document, error in
                if let data = document?.data() {
                    if data.count > 1 {
                        let sampleData = SampleModel(data: data)
                        self.fetchData(res: [sampleData])
                    }
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
        print(samplesData)
    }
    
    func createCellModel(cell: SampleModel) -> DataCellModel {

        for img in cell.sampleImageUrl {
            let storageRefrence = self.st?.reference(forURL: img)
            storageRefrence?.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.dismissAlert?(true)
                    self.reloadTableView?()
                    self.sampleImage = UIImage(data: data!)
                }
            })
        }
        
        for name in cell.sampleName {
            sampleName = name
        }
        
        for smp in cell.sampleUrl {
            let storageRefrence = self.st?.reference(forURL: smp)
            storageRefrence?.getData(maxSize: 3 * 1024 * 1024, completion: { data, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print(data)
                }
            })
        }
        return DataCellModel(imageSample: sampleImage ?? (UIImage(systemName: Icons.photo.rawValue)!), sampleName: sampleName!, sampleData: "")
    }
    
    func getCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesData[indexPath.row]
    }

}
