//
//  SongCell.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SongCell : BaseTableViewCell {
    
    let songImageView : UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "profile_image"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let songTitle : UITextView = {
        var textView = UITextView()
        textView.text = "Childish Gambino "
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainer.maximumNumberOfLines = 2
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.font = UIFont(name: (textView.font?.fontName)!, size: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let songDurationLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: (label.font.fontName), size: 12)
        label.text = "0:50"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(songImageView)
        addSubview(songTitle)
        addSubview(songDurationLabel)
        setConstraints()
    }
    
    func setConstraints() {
        //Song image constraints
        songImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        songImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        songImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        songImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        //Song title constraints
        songTitle.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8).isActive = true
        songTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        songTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        songTitle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //Song duration constraints
        songDurationLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 16).isActive = true
        songDurationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        songDurationLabel.topAnchor.constraint(equalTo: songTitle.bottomAnchor).isActive = true
    }
    
}
