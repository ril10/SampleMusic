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


class SellerDetailViewModel: ContainerImp,SellerImp {

    var container: DependencyContainer!
    var disposeBag : DisposeBag!
    var reloadView : (() -> Void)?
    var db : Firestore?
    var isLogout : ((Bool) -> Void)?
    var image: ((Data) -> Void)?
    var fieldData : ((String,String,String,String,String) -> Void)?
    init() {
        self.container = appContainer
        self.db = try! container.resolve() as Firestore
    }
    
    
    func userData() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if ((user) != nil) {
                self?.db?.collection(Role.seller.rawValue.lowercased()).document(user!.uid).getDocument(completion: { (document, error) in

                    
//                    let result = Result// {
////                        try document?.data(as: DetailModel.self)
//                    //}
//                        switch result {
//                        case .success(let data):
//                            if let data = data {
//                                self?.fieldData?(
//                                    data.firstName,
//                                    data.lastName,
//                                    data.description,
//                                    data.email,
//                                    data.gender
//                                )
//                                self?.downloadImage(from: URL(string: data.imageUrl)!)
//                            } else {
//                                print("Error")
//                            }
//                        case .failure(let error):
//                            print("Error decoding data:\(error)")
//                        }
                })
            }
        }
    }
    
    func downloadImage(from url: URL) {
        func downloadImage(from url: URL) {
            URLSession.shared.rx
                .response(request: URLRequest(url: url))
                .subscribe(onNext: { (response, data) in
                    DispatchQueue.main.async {
                        self.image?(data)
                        self.reloadView?()
                    }
                }).disposed(by: self.disposeBag)
        }
    }
    
    func logout() {
            do {
                try Auth.auth().signOut()
                isLogout?(true)
            } catch let signOutError as NSError {
                print(signOutError.localizedDescription)
            }
    }
}
