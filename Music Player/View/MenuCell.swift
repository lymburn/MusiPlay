//
//  MenuCell.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//


import UIKit

class MenuCell : BaseCollectionViewCell {
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile_image"))
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
        }
    }
    
    override func setupViews() {
        super.setupViews()
        //addSubview(imageView)
        self.backgroundColor = UIColor.blue
    }
}

