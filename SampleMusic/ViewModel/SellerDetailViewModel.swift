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
import RxSwift
import RxCocoa


class SellerDetailViewModel: SellerImp {

    var disposeBag : DisposeBag!
    var reloadView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var image: ((Data) -> Void)?
    var fieldData : ((String,String,String,String,String) -> Void)?
    init(db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    
    
    func userData() {
        if let user = Auth.auth().currentUser {
                self.db?.collection(Role.seller.rawValue.lowercased()).document(user.uid).getDocument(completion: { (document, error) in
                    if let data = document?.data() {
                        let sellerData = DetailModel(data: data)
                            self.fieldData?(sellerData.firstName,sellerData.lastName,sellerData.description,sellerData.email,sellerData.gender)
                        let imgRef = self.st?.reference(forURL: sellerData.imageUrl)
                        imgRef?.getData(maxSize: 3 * 1024 * 1024, completion: { data, error in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                self.image?(data!)
                            }
                        })
                    }
                })
            }
    }

}
