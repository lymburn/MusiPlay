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
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var songTitle : UITextView = {
        var textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textContainer.maximumNumberOfLines = 2
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.font = UIFont(name: "Helvetica Neue", size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let channelLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name:  "Helvetica Neue", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        self.layoutMargins = UIEdgeInsets.zero
        addSubview(songImageView)
        addSubview(songTitle)
        addSubview(channelLabel)
        setConstraints()
    }
    
    func setConstraints() {
        //Song image constraints
        songImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        songImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        songImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        songImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        //Song title constraints
        songTitle.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 8).isActive = true
        songTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        songTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        songTitle.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //Song duration constraints
        channelLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 16).isActive = true
        channelLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        channelLabel.topAnchor.constraint(equalTo: songTitle.bottomAnchor).isActive = true
    }
    
}
