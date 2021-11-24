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
import AVFoundation


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
    var sampleUrl = [String]()
    var totalSeconds : Int?

    
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
                    DispatchQueue.main.async {
                        self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender)
                    }
                }
            })
        }
    }
    
    
    
    func getSamplesData() {
        if let user = Auth.auth().currentUser {
            let refrence = db?.collection(Role.sample.rawValue.lowercased())
            refrence?.whereField("ownerUid", isEqualTo: user.uid)
                .addSnapshotListener(includeMetadataChanges: true, listener: { documentSnapshot, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        var resData = [SampleModel]()
                        for document in documentSnapshot!.documents {
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
            resData.append(self.createCellModel(cell: r))
        }
        samplesData = resData
        
    }
    
    func createCellModel(cell: SampleModel) -> DataCellModel {
        
        self.imageArray.append(cell.sampleImageUrl)
        for img in self.imageArray {
            self.imageView.sd_setImage(with: (self.st?.reference(forURL: img))!,placeholderImage: UIImage(systemName: Icons.photo.rawValue))
        }
        
        self.sampleUrl.append(cell.sampleUrl)
        for smp in self.sampleUrl {
            self.sampleData = smp
        }
        
        let name = cell.sampleName

        let duratation = self.sampleDuratation(for: cell.sampleUrl)

        
        return DataCellModel(imageSample: imageView.image ?? UIImage(systemName: Icons.photo.rawValue)!,
                             sampleName: name,
                             sampleData: self.sampleData ?? "",
                             totalSeconds: self.totalSeconds!,
                             sampleDuratation: duratation
        )
    }
    
    func sampleDuratation(for resource: String) -> String {
        let asset = AVAsset(url: URL(string: resource)!)
        let totalSeconds = Int(CMTimeGetSeconds(asset.duration))
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        self.totalSeconds = totalSeconds
        return String(format:"%02i:%02i",minutes, seconds)
    }
    
    func getCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesData[indexPath.row]
    }

}
