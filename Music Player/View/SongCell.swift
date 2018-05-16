//
//  SongCell.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SongCell : UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    let songImageView : UIImageView = {
        var imageView = UIImageView(image: UIImage(named: "profile_image"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let songTitle : UITextView = {
        var title = UITextView()
        title.text = "Titlecxvcxcvcxvcxvxmncvxccvx cxvmnccvcnxzcxzncxzcxzvczvxvnczxczxvzcxnbczxvczxnvcxzvvnczbxnv"
        title.isScrollEnabled = false
        title.isEditable = false
        title.font = UIFont(name: (title.font?.fontName)!, size: 20)
        //title.textContainerInset = UIEdgeInsetsMake(0, -8, 0, 0)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let songDurationLabel : UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: (label.font.fontName), size: 12)
        label.text = "0:50"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
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
        songTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Song duration constraints
        songDurationLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 16).isActive = true
        songDurationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
        songDurationLabel.topAnchor.constraint(equalTo: songTitle.bottomAnchor, constant: 8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
