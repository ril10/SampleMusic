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
        image.image = UIImage(systemName: Style.photo.rawValue)
        image.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        image.layer.borderWidth = 1.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor(named: Style.colorButton.rawValue)?.cgColor
        image.layer.cornerRadius = image.frame.size.width / 2
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var buttonPlay : UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: "play",withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor.black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var labelSample : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(imageUser)
        contentView.addSubview(labelSample)
        contentView.addSubview(buttonPlay)
        
        
        NSLayoutConstraint.activate([
            labelSample.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            labelSample.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            labelSample.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            imageUser.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 40),
            imageUser.leadingAnchor.constraint(equalTo: labelSample.trailingAnchor,constant: 15),
            imageUser.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -40),
            buttonPlay.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonPlay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
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
