//
//  UserDetailViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 18.11.21.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import RealmSwift


class UserDetailViewModel: UserDetailViewModelImp  {
    
    var reloadView: (() -> Void)?
    var fieldData: ((String, String, String, String, String, String) -> Void)?
    var image: ((Data) -> Void)?
    var dismissAlert: ((Bool) -> Void)?
    var db : Firestore?
    var st : Storage?
    var balanceStatus : ((String) -> Void)?
    var totalSeconds : Int?
    var duratation : String?
    
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    var purchasedSamples = [PurchasedModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView : (() -> Void)?
    
    func userData() {
        if let user = Auth.auth().currentUser {
            self.db?.collection(Collection.user.getCollection()).document(user.uid).addSnapshotListener( { (document, error) in
                if let data = document?.data() {
                    let sellerData = DetailModel(data: data)
                    self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender,sellerData.imageUrl)
                    self.balanceStatus?("\(sellerData.balance!)🍪")
                    self.dismissAlert?(true)
                }
            })
        }
    }
    
    //MARK: - Get Sample Data
    func getPurchasedSamplesData() {
        if let user = Auth.auth().currentUser {
            let refrence = db?.collection(Collection.purchased.getCollection())
            refrence?.whereField("purchasedUid", isEqualTo: user.uid)
                .addSnapshotListener(includeMetadataChanges: true, listener: { documentSnapshot, error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        var resData = [Purchased]()
                        for document in documentSnapshot!.documents {
                            let sampleData = Purchased(data: document.data())
                            resData.append(sampleData)
                        }
                        self.fetchData(res: resData)
                    }
                })
        }
    }
    //MARK: - Create Cell & Fetch Data
    func fetchData(res: [Purchased]) {
        var resData = [PurchasedModel]()
        for r in res {
            resData.append(self.createCellModel(cell: r))
        }
        purchasedSamples = resData
    }
    
    func createCellModel(cell: Purchased) -> PurchasedModel {
        let purchaseUid = cell.purchasedUid
        let imageUrl = cell.imageUrl
        let sampleName = cell.sampleName
        let sampleUrl = cell.sampleUrl
        
        let totalSeconds = cell.duration ?? 0
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        self.totalSeconds = totalSeconds
        self.duratation = String(format:"%02i:%02i",minutes, seconds)
                
        return PurchasedModel(purchasedUid: purchaseUid,
                              imageUrl: imageUrl,
                              sampleName: sampleName,
                              sampleUrl: sampleUrl,
                              duration: self.duratation ?? "",
                              totalSeconds: self.totalSeconds ?? 0
        )
    }
 
    func getCellModel(at indexPath: IndexPath) -> PurchasedModel {
        return purchasedSamples[indexPath.row]
    }
     
    
    
}
