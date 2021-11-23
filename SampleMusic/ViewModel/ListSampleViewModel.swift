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
    var sampleData : String?
    let imageView = UIImageView()
    var imageArray = [String]()
    var player : MusicPlayerProtocol
    
    var samplesData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    init (db: Firestore,st: Storage,player: MusicPlayerProtocol) {
        self.db = db
        self.st = st
        self.player = player
    }
    //MARK: - TableViewData
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
        imageArray.append(cell.sampleImageUrl)
        for img in imageArray {
            DispatchQueue.main.async {
                self.imageView.sd_setImage(with: (self.st?.reference(forURL: img))!)
            }
        }

        let ref = self.st?.reference().child("musicSamples/\(cell.sampleName).mp3")
        ref?.downloadURL(completion: { url, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.sampleData = url?.absoluteString
                DispatchQueue.main.async {
                    self.player.configure(sampleData: url!.absoluteString)
                }
            }
        })
        
        return DataCellModel(imageSample: ((imageView.image) ?? UIImage(systemName: Icons.photo.rawValue))!, sampleName: sampleName, sampleData:  "https://firebasestorage.googleapis.com/v0/b/samplemusic-b90e3.appspot.com/o/musicSamples%2FHdhd.mp3?alt=media&token=cdcd13a9-4fce-451c-b73b-dd831c4890cd")
    }
    
    func getCellModel(at indexPath: IndexPath) -> DataCellModel {
        return samplesData[indexPath.row]
    }
    //MARK: - Filter
    func filterByName() {
       let sortedByName = samplesData.sorted { $0.sampleName < $1.sampleName }
       samplesData = sortedByName
    }
    
    func filterByTrackLength() {
        
    }
    
    //MARK: - Search
    func searchResults(text: String) {
        let search = samplesData.filter { $0.sampleName.contains(text) }
        samplesData = search
    }
    //MARK: - LogOut
    func logout() {
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
    }
    
}
