//
//  UserMessageCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit
import SDWebImage
import Dip
import FirebaseStorage

class ChatListCell: UITableViewCell {

    var st = try! appContainer.resolve() as Storage
    
    var chatSell : CellChatModel? {
        didSet {
            lastMessage.text = chatSell?.message
            getImage(with: chatSell?.ownerUid ?? "")
        }
    }
    
    private func getImage(with uid: String) {
         st.reference(withPath: "userAvatars/\(uid).jpg")
         .downloadURL(completion: { url, error in
             if let error = error {
                 print(error.localizedDescription)
             } else {
                 DispatchQueue.main.async {
                     self.imageUser.sd_setImage(with: url , placeholderImage: UIImage(systemName: Icons.photo.rawValue))
                 }
             }
         })
     }
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageUser,lastMessage])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var messageView : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
        image.layer.cornerRadius = 10
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var imageUser : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        image.image = UIImage(systemName: Icons.photo.rawValue)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var lastMessage : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(messageView)
        messageView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            messageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            messageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            messageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            messageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: messageView.topAnchor,constant: 10),
            stackView.leadingAnchor.constraint(equalTo: messageView.leadingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor,constant: -10),
            stackView.bottomAnchor.constraint(equalTo: messageView.bottomAnchor,constant: -10),
            
            imageUser.widthAnchor.constraint(equalToConstant: 100),
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
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
