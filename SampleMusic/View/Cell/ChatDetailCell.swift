//
//  ChatDetailCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit
import SDWebImage
import FirebaseStorage
import Dip

class ChatDetailCell: UITableViewCell {
    
    let st = try! appContainer.resolve() as Storage
    
    var messageCell : Message? {
        didSet {
            message.text = messageCell?.body
            getLeftImage(with: messageCell?.recieverUid ?? "")
            getRightImage(with: messageCell?.senderUid ?? "")
        }
    }

   private func getLeftImage(with uid: String) {
        st.reference(withPath: "userAvatars/\(uid).jpg")
        .downloadURL(completion: { url, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.leftImage.sd_setImage(with: url , placeholderImage: UIImage(systemName: Icons.photo.rawValue))
                }
            }
        })
    }
    
    private func getRightImage(with uid: String) {
        st.reference(withPath: "userAvatars/\(uid).jpg")
        .downloadURL(completion: { url, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.rightImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: Icons.photo.rawValue))
                }
            }
        })
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
    
    var message : UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20)
        textView.textColor = UIColor(named: Style.textColor.rawValue)
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.sizeToFit()
        textView.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        textView.layer.borderWidth = 1.0
        textView.layer.masksToBounds = false
        textView.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
        textView.layer.cornerRadius = textView.frame.size.height / 2
        textView.clipsToBounds = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(leftImage)
        contentView.addSubview(rightImage)
        contentView.addSubview(message)

        
        NSLayoutConstraint.activate([
            message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -60),
            message.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 50),
            message.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            message.topAnchor.constraint(equalTo: contentView.topAnchor),

            leftImage.widthAnchor.constraint(equalToConstant: 50),
            leftImage.heightAnchor.constraint(equalToConstant: 50),
            rightImage.widthAnchor.constraint(equalToConstant: 50),
            rightImage.heightAnchor.constraint(equalToConstant: 50),
            

        ])
        
        if leftImage.isHidden == true {
            NSLayoutConstraint.activate([
                message.leadingAnchor.constraint(equalTo: rightImage.leadingAnchor)
            ])
            
        } else {
            NSLayoutConstraint.activate([
                message.trailingAnchor.constraint(equalTo: rightImage.trailingAnchor,constant: -50),
                message.leadingAnchor.constraint(equalTo: leftImage.trailingAnchor),
            ])
        }

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
