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
import AVFoundation

class ListSampleViewModel: ListSamplesImp {

    var reloadTableView : (() -> Void)?
    var db : Firestore?
    var st : Storage?
    var image : UIImage?
    var dismissAlert: ((Bool) -> Void)?
    var sampleData : String?
    let imageView = UIImageView()
    var imageArray = [String]()
    var sampleUrl = [String]()
    
    var samplesData = [DataCellModel]() {
        didSet {
            reloadTableView?()
        }
    }
    init (db: Firestore,st: Storage) {
        self.db = db
        self.st = st
    }
    //MARK: - TableViewData
    func getSamplesData() {
            db?.collection(Role.sample.rawValue.lowercased())
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
            self.imageView.sd_setImage(with: (self.st?.reference(forURL: img))!)
        }

        self.sampleUrl.append(cell.sampleUrl)
        for smp in self.sampleUrl {
            self.sampleData = smp
        }
        let duratation = self.sampleDuratation(for: cell.sampleUrl)
        
        return DataCellModel(imageSample: ((imageView.image) ?? UIImage(systemName: Icons.photo.rawValue))!, sampleName: sampleName, sampleData: sampleData ?? "", sampleDuratation: duratation)
    }
    
    func sampleDuratation(for resource: String) -> String {
        let asset = AVAsset(url: URL(string: resource)!)
        let totalSeconds = Int(CMTimeGetSeconds(asset.duration))
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format:"%02i:%02i",minutes, seconds)
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
