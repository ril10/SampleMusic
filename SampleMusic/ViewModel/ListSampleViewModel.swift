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
                    
                    sampleData.sampleImageUrl.map { val in
                        let storageRefrence = self.st?.reference(forURL: val)
                        storageRefrence?.getData(maxSize: 1 * 1024 * 1024, completion: { data, error in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                print(data)
                            }
                        })
                    }
                    
                    sampleData.sampleUrl.map { val in
                        let storageRefrence = self.st?.reference(forURL: val)
                        storageRefrence?.getData(maxSize: 3 * 1024 * 1024, completion: { data, error in
                            if let error = error {
                                print(error.localizedDescription)
                            } else {
                                print(data)
                            }
                        })
                    }
                    
                    sampleData.sampleName.map { val in
                        print(val)
                    }
                    
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
