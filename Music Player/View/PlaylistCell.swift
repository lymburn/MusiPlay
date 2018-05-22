//
//  PlaylistCell.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-22.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class PlaylistCell: BaseTableViewCell {
    
    let title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: label.font.fontName, size: 14)
        return label
    }()
    
    let thumbnail : UIImageView = {
        let tn = UIImageView()
        tn.translatesAutoresizingMaskIntoConstraints = false
        return tn
    }()
    
    let itemCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: label.font.fontName, size: 12)
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(title)
        addSubview(thumbnail)
        addSubview(itemCount)
        setConstraints()
    }
    
    private func setConstraints() {
        thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        thumbnail.heightAnchor.constraint(equalToConstant: 90).isActive = true
        thumbnail.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        //Song title constraints
        title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 8).isActive = true
        title.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -16).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        //Song duration constraints
        itemCount.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 12).isActive = true
        itemCount.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -16).isActive = true
        itemCount.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
    }
}
