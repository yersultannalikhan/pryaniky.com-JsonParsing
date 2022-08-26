//
//  ImageCell.swift
//  JsonParsing
//
//  Created by Yersultan Nalikhan on 26.08.2022.
//

import UIKit
import Kingfisher

class ImageCell: UITableViewCell {
    static let reuseIdentifier = "imageCell"
    
    var data: ImageData? {
        didSet {
            guard let data = data, let url = URL(string: data.url) else {
                return
            }
            myLabel.text = data.text
            myImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            myImageView.kf.indicatorType = .activity
        }
    }
    
    let myImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "placeholder")
        return iv
    }()
    
    let myLabel: UILabel = {
        let l = UILabel()
        l.text = "Text"
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [myImageView, myLabel].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        myImageView.anchorCenterY(centerY: centerYAnchor)
        myImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0), size: .init(width: 35, height: 35))
        
        myLabel.anchorCenterY(centerY: centerYAnchor)
        myLabel.anchor(top: nil, leading: myImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
    }
}
