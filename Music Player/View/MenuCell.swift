//
//  MenuCell.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//


import UIKit

class MenuCell: BaseCollectionViewCell {
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Trending"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? UIColor.rgb(red: 138, green: 43, blue: 226) : UIColor.gray
            iconLabel.textColor = isHighlighted ? UIColor.rgb(red: 138, green: 43, blue: 226) : UIColor.gray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? UIColor.rgb(red: 138, green: 43, blue: 226) : UIColor.gray
            iconLabel.textColor = isSelected ? UIColor.rgb(red: 138, green: 43, blue: 226) : UIColor.gray
        }
    }
    
    func setupConstraints() {
        //Image view constraints
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        //Label constraints
        iconLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    }
    
    override func setupViews() {
        super.setupViews()
        self.addSubview(imageView)
        addSubview(iconLabel)
        setupConstraints()
    }
}

