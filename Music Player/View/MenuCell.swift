//
//  MenuCell.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//


import UIKit

class MenuCell: BaseCollectionViewCell {
    var selectedIcon: String!
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let iconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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

