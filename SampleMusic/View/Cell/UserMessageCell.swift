//
//  UserMessageCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 26.11.21.
//

import UIKit

class UserMessageCell: UITableViewCell {

    lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageUser,lastMessage])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var imageUser : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        image.image = UIImage(systemName: Icons.photo.rawValue)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.colorButton.rawValue)?.cgColor
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
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageUser.widthAnchor.constraint(equalToConstant: 100),
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
