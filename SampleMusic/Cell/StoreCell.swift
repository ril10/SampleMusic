//
//  StoreCell.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 16.12.21.
//

import UIKit
import SDWebImage
import Dip
import FirebaseFirestore

class StoreCell: UITableViewCell {
    
    let db = try! appContainer.resolve() as Firestore
    
    var storeCell : StoreCellModel? {
        didSet {
            promotionLabel.text = storeCell?.name
            costLabel.text = "\(storeCell!.cost)$"
            recievedCookies.text = "\(storeCell!.cost)🍪"
            cellImage(with: storeCell!.image)
        }
    }
    
    private func cellImage(with link: String) {
        DispatchQueue.main.async {
            self.imageDeal.sd_setImage(with: URL(string: link), placeholderImage: UIImage(systemName: Icons.photo.rawValue))
        }
    }
    
    lazy var stackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageDeal,middleStackView,endStackView])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var middleStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [promotionLabel,recievedCookies])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var endStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buyButton,costLabel])
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var dealView : UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.tintColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor(named: Style.coralColor.rawValue)?.cgColor
        view.layer.cornerRadius = 10
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageDeal : UIImageView = {
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
    
    var buyButton : UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        button.setImage(UIImage(systemName: Icons.banknote.rawValue,withConfiguration: largeConfig),for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var promotionLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20)
        label.textColor = UIColor(named: Style.textColor.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var costLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20)
        label.textColor = UIColor(named: Style.textColor.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var recievedCookies: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: Style.fontTitleLight.rawValue, size: 20)
        label.textColor = UIColor(named: Style.textColor.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dealView)
        dealView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            dealView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dealView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dealView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            dealView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: dealView.topAnchor,constant: 10),
            stackView.leadingAnchor.constraint(equalTo: dealView.leadingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: dealView.trailingAnchor,constant: -10),
            stackView.bottomAnchor.constraint(equalTo: dealView.bottomAnchor,constant: -10),

            
            imageDeal.widthAnchor.constraint(equalToConstant: 100),
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
