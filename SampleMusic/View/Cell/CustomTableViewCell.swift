//
//  CustomTableViewCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.10.21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    var sampleCell : SampleModel? {
        didSet {
            imageUser.image = sampleCell?.userImage
            labelSample.text = sampleCell?.sampleLabel
        }
    }
    
    var imageUser : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    var labelSample : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 10)
        label.textColor = .lightGray
        return label
    }()
            
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageUser)
        addSubview(labelSample)
        
        NSLayoutConstraint.activate([
            imageUser.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageUser.topAnchor.constraint(equalTo: topAnchor),
            imageUser.bottomAnchor.constraint(equalTo: bottomAnchor),
            labelSample.topAnchor.constraint(equalTo: topAnchor),
            labelSample.leadingAnchor.constraint(equalTo: imageUser.trailingAnchor,constant: 5),
            labelSample.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
