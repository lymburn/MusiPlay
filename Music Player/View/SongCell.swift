//
//  SongCell.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

protocol SongCellDelegate: class {
    func addSongButtonPressed(index: Int)
}

class SongCell : BaseTableViewCell {
    
    weak var delegate: SongCellDelegate?
    private var songAdded: Bool = false //Track if the song has already been added
    var index: Int! //Cell row
    
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
        textView.isUserInteractionEnabled = false
        textView.textContainer.maximumNumberOfLines = 2
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.font = UIFont(name: "Helvetica Neue", size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        //Allows for auto resizing
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
        return textView
    }()
    
    lazy var addSongButton: UIButton = {
        var button = UIButton()
        button.setTitle("➕", for: .normal)
        button.titleLabel!.font = UIFont(name: button.titleLabel!.font.fontName, size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addSong), for: .touchDown)
        return button
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
        addSubview(addSongButton)
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
        songTitle.trailingAnchor.constraint(equalTo: addSongButton.leadingAnchor, constant: -16).isActive = true
        songTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        
        //Song duration constraints
        channelLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 12).isActive = true
        channelLabel.trailingAnchor.constraint(equalTo: addSongButton.leadingAnchor, constant: -16).isActive = true
        channelLabel.topAnchor.constraint(equalTo: songTitle.bottomAnchor).isActive = true
        
        //Add song button constraints
        addSongButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addSongButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        addSongButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc func addSong() {
        if !songAdded {
            self.delegate?.addSongButtonPressed(index: index)
            addSongButton.setTitle("✔️", for: .normal)
            songAdded = true
        }
    }
}
