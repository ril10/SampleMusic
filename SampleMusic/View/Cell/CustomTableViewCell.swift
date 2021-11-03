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
    
    lazy var stackViewLeft : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelSample,imageUser])
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewRight : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonPlay,slider])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var imageUser : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Icons.photo.rawValue)
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
        button.setImage(UIImage(systemName: Icons.play.rawValue,withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor(named: Style.colorButton.rawValue)
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
    
    var slider : UISlider = {
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        slider.value = 0.5
        slider.tintColor = UIColor(named: Style.colorButton.rawValue)
        slider.addTarget(self, action: #selector(didSliderSlider(slider:)), for: .valueChanged)
        return slider
    }()
    
    @objc func didSliderSlider(slider: UISlider!) {
        let value = slider.value
        
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackViewLeft)
        contentView.addSubview(stackViewRight)
        
        NSLayoutConstraint.activate([
            stackViewLeft.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            stackViewLeft.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            stackViewLeft.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            stackViewLeft.trailingAnchor.constraint(equalTo: stackViewRight.leadingAnchor,constant: -10),
            stackViewRight.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            stackViewRight.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            stackViewRight.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
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
