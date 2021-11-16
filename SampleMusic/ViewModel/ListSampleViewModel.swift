//
//  ListSampleViewModel.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 3.11.21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Dip

class ListSampleViewModel: ListSamplesImp {

    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var samplesData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    init (db: Firestore) {
        self.db = db
    }
    
    func getSamplesData() {
        if let user = Auth.auth().currentUser {
            self.db?.collection(Role.seller.rawValue.lowercased()).document(user.uid).getDocument(completion: { document, error in
                if let data = document?.data() {
                    let samplesData = SampleModel(data: data)
                    print(samplesData.sampleName)
                    print(samplesData.sampleUrl)
                    print(samplesData.sampleImageUrl)
                }
            })
        }
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
