//
//  ChatDetailCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit

class ChatDetailCell: UITableViewCell {
    
    var messageCell : Message? {
        didSet {
            message.text = messageCell?.body
            leftImage.image = messageCell?.leftImage
            rightImage.image = messageCell?.rightImage
        }
    }

    var messageView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var leftImage : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        image.image = UIImage(systemName: Icons.photo.rawValue)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.colorButton.rawValue)?.cgColor
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
        image.layer.borderColor = UIColor(named: Style.colorButton.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.height / 2
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var message : UILabel = {
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
        messageView.addSubview(leftImage)
        messageView.addSubview(message)
        messageView.addSubview(rightImage)
        
        NSLayoutConstraint.activate([
            leftImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            leftImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            leftImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            message.leadingAnchor.constraint(equalTo: leftImage.trailingAnchor,constant: 15),
            message.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            message.topAnchor.constraint(equalTo: contentView.topAnchor),
            rightImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            rightImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            rightImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            leftImage.widthAnchor.constraint(equalToConstant: 50),
            rightImage.widthAnchor.constraint(equalToConstant: 50),
        ])
        
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
