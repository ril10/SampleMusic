//
//  CustomTableViewCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 29.10.21.
//

import UIKit
import AVFoundation
import Dip

class CustomTableViewCell: UITableViewCell {
    
    var sampleData : String!
    var position = 0
    
    var player = try! appContainer.resolve() as MusicPlayerProtocol

    
    var sampleCell : DataCellModel? {
        didSet {
            imageUser.image = sampleCell?.imageSample
            labelSample.text = sampleCell?.sampleName
            sampleData = sampleCell?.sampleData
            endTimeLabel.text = sampleCell?.sampleDuratation
        }
    }
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewLeft,imageUser])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewLeft : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelSample,stackViewRight])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var stackViewRight : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonPlay,startTimeLabel,slider,endTimeLabel])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
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
    
    var buttonPlay : UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: Icons.play.rawValue,withConfiguration: largeConfig), for: .normal)
        button.tintColor = UIColor(named: Style.colorButton.rawValue)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playMusic(sender:)), for: .touchUpInside)
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
        let slider = UISlider(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        slider.value = 0.0
        slider.tintColor = UIColor(named: Style.colorButton.rawValue)
        slider.addTarget(self, action: #selector(didSlider(slider:)), for: .valueChanged)
        return slider
    }()
    
    var startTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        return label
    }()
    
    var endTimeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        return label
    }()
    
    @objc func didSlider(slider: UISlider!) {
        slider.minimumValue = 0
        slider.maximumValue = Float(sampleCell!.totalSeconds)
        var value = Int(slider.value)

        if value >= 60 {
            startTimeLabel.text = String(format: "%02d:%02d", (value / 60), (value % 60))
        } else {
            startTimeLabel.text = String(format: "00:%02d", value)
        }
        
        
    }
    
    @objc func playMusic(sender: UIButton!) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        if  player.player?.isPlaying == true {
            buttonPlay.setImage(UIImage(systemName: Icons.play.rawValue,withConfiguration: largeConfig), for: .normal)
            player.configure(sampleData: sampleData)

        } else {
            buttonPlay.setImage(UIImage(systemName: Icons.pause.rawValue,withConfiguration: largeConfig), for: .normal)
            player.configure(sampleData: sampleData)
        }
    }
    
    
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
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
