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
                    if let data = document?.data() {
                        self!.fetchData(data)
                    }
                })
            }
        }
    }
    
    func fetchData(_ data: [String: Any]) {
        let fetchData = data.map { data -> DetailModel in
            
            return DetailModel(firstName: "", lastName: "", description: "", email: "", gender: "", imageUrl: "")
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
}
