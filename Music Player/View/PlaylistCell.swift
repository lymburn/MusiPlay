//
//  PlaylistCell.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-22.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class PlaylistCell: BaseTableViewCell {
    
    var title : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 24)
        return label
    }()
    
    var thumbnail : UIImageView = {
        let tn = UIImageView(image: UIImage(named: "Record.png"))
        tn.translatesAutoresizingMaskIntoConstraints = false
        return tn
    }()
    
    var itemCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = UIColor.gray
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
        thumbnail.widthAnchor.constraint(equalToConstant: 90).isActive = true
        
        
        //Song title constraints
        title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 16).isActive = true
        title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        title.topAnchor.constraint(equalTo: topAnchor, constant: 28).isActive = true
        
        //Song duration constraints
        itemCount.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 16).isActive = true
        itemCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        itemCount.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
 
    }
}
