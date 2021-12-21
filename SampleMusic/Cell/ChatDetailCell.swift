//
//  ChatDetailCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit
import SDWebImage
import FirebaseFirestore
import Dip
import RealmSwift

class ChatDetailCell: UITableViewCell {
    
    let db = try! appContainer.resolve() as Firestore
    let state = try! Realm()
    
    var messageCell : Message? {
        didSet {
            message.text = messageCell?.body
            cellImage(with: messageCell?.recieverUid ?? "", with: messageCell?.senderUid ?? "")
            cellImage(with: messageCell?.senderUid ?? "", with: messageCell?.recieverUid ?? "")
        }
    }

    private func cellImage(with leftImage: String, with rightImage: String) {
        let type = state.objects(State.self).first
        switch type?.role {
        case Collection.seller.getCollection():
            getImageUrl(type: Collection.seller.getCollection(), by: rightImage) { img in
                DispatchQueue.main.async {
                    self.rightImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(systemName: Icons.photo.rawValue))
                }
            }
            getImageUrl(type: Collection.user.getCollection(), by: leftImage) { img in
                DispatchQueue.main.async {
                    self.leftImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(systemName: Icons.photo.rawValue))
                }
            }
        case Collection.user.getCollection():
            getImageUrl(type: Collection.user.getCollection(), by: rightImage) { img in
                DispatchQueue.main.async {
                    self.rightImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(systemName: Icons.photo.rawValue))
                }
            }
            getImageUrl(type: Collection.seller.getCollection(), by: leftImage) { img in
                DispatchQueue.main.async {
                    self.leftImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(systemName: Icons.photo.rawValue))
                }
            }
        default:
            break
        }
    }
    
    private func getImageUrl(type role: String, by uid: String, completion: @escaping (String) -> Void?) {
        self.db.collection(role).document(uid)
            .addSnapshotListener { (documentSnapshot, _) in
                if let document = documentSnapshot, document.exists {
                    let imageUrl = DetailModel(data: document.data()!)
                    completion(imageUrl.imageUrl)
                }
            }
    }
    
    var leftImage : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.image = UIImage(systemName: Icons.photo.rawValue)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.height / 2
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var rightImage : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.image = UIImage(systemName: Icons.photo.rawValue)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.height / 2
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
//    var message : UITextView = {
//        let textView = UITextView()
//        textView.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20)
//        textView.textColor = UIColor(named: Style.textColor.rawValue)
//        textView.isScrollEnabled = false
//        textView.isEditable = false
//        textView.sizeToFit()
//        textView.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
//        textView.layer.borderWidth = 1.0
//        textView.layer.masksToBounds = false
//        textView.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
//        textView.layer.cornerRadius = textView.frame.size.height / 2
//        textView.clipsToBounds = true
//        textView.translatesAutoresizingMaskIntoConstraints = false
//        return textView
//    }()
    
    var message : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20)
        label.textColor = UIColor(named: Style.textColor.rawValue)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var chatBubbleView: UIView = {
        let view = UIView()
        view.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
        view.layer.cornerRadius = 10
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(leftImage)
        contentView.addSubview(rightImage)
        contentView.addSubview(message)
        contentView.addSubview(chatBubbleView)

        
        NSLayoutConstraint.activate([
//            message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -60),
//            message.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 50),
            message.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            message.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            message.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60),
            message.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),

            leftImage.widthAnchor.constraint(equalToConstant: 50),
            leftImage.heightAnchor.constraint(equalToConstant: 50),
            rightImage.widthAnchor.constraint(equalToConstant: 50),
            rightImage.heightAnchor.constraint(equalToConstant: 50),
        ])
        NSLayoutConstraint.activate([
            chatBubbleView.topAnchor.constraint(equalTo: message.topAnchor,constant: -16),
            chatBubbleView.leadingAnchor.constraint(equalTo: message.leadingAnchor,constant: -16),
            chatBubbleView.trailingAnchor.constraint(equalTo: message.trailingAnchor,constant: 16),
            chatBubbleView.bottomAnchor.constraint(equalTo: message.bottomAnchor,constant: 16),
        ])
        
        if leftImage.isHidden == true {
            NSLayoutConstraint.activate([
                message.trailingAnchor.constraint(equalTo: rightImage.leadingAnchor),
                message.leadingAnchor.constraint(equalTo: rightImage.leadingAnchor),
                
            ])
            
        } else {
            NSLayoutConstraint.activate([
                message.trailingAnchor.constraint(equalTo: rightImage.trailingAnchor,constant: -50),
                message.leadingAnchor.constraint(equalTo: leftImage.trailingAnchor),
            ])
        }

    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
