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
import FirebaseStorageUI


class SellerDetailViewModel: SellerImp {
    
    var reloadView : (() -> Void)?
    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var image: ((Data) -> Void)?
    var dismissAlert: ((Bool) -> Void)?
    var fieldData : ((String,String,String,String,String) -> Void)?
    var sampleData : String?
    let imageView = UIImageView()
    var imageArray = [String]()
    var player = MusicPlayer()
    
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
                            self.dismissAlert?(true)
                        }
                    })
                    self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender)
                }
            })
        }
    }
    
    
    
    func getSamplesData() {
        var resData = [SampleModel]()
        if let user = Auth.auth().currentUser {
            let refrence = db?.collection(Role.sample.rawValue.lowercased())
            refrence?.whereField("ownerUid", isEqualTo: user.uid)
                .getDocuments(completion: { query, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        for document in query!.documents {
                            let sampleData = SampleModel(data: document.data())
                            resData.append(sampleData)
                        }
                    }
                    self.fetchData(res: resData)
                })
        }
    }
    
    func fetchData(res: [SampleModel]) {
        var resData = [DataCellModel]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        samplesData = resData
    }
    
    func createCellModel(cell: SampleModel) -> DataCellModel {
            
            self.imageArray.append(cell.sampleImageUrl)
            for img in self.imageArray {
                self.imageView.sd_setImage(with: (self.st?.reference(forURL: img))!,placeholderImage: UIImage(systemName: Icons.photo.rawValue))
            }

            let ref = self.st?.reference().child("musicSamples/\(cell.sampleName).mp3")
            ref?.downloadURL(completion: { url, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.sampleData = url?.absoluteString
                    self.player.configure(sampleData: url!.absoluteString)
                    
                }
            })
        let name = cell.sampleName

        return DataCellModel(imageSample: imageView.image ?? UIImage(systemName: Icons.photo.rawValue)!, sampleName: name, sampleData: sampleData ??  "https://firebasestorage.googleapis.com/v0/b/samplemusic-b90e3.appspot.com/o/musicSamples%2FHdhd.mp3?alt=media&token=cdcd13a9-4fce-451c-b73b-dd831c4890cd")
    }
    
    func getCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesData[indexPath.row]
    }
    
}
