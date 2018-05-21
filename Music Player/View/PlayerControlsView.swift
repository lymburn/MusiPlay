//
//  PlayerControlsView.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-20.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class PlayerControlsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let videoTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currentTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 16)
        label.text = "00:00"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 16)
        label.text = "00:00"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .purple
        return slider
    }()
    
    let previousVideoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Previous.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nextVideoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Next.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Play.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let lowerVolume: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let higherVolume: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
}

//MARK: Setup
extension PlayerControlsView {
    fileprivate func setupViews() {
        addSubview(videoTitle)
        addSubview(currentTimeLabel)
        addSubview(durationLabel)
        addSubview(videoSlider)
        
        addSubview(previousVideoButton)
        addSubview(nextVideoButton)
        addSubview(pauseButton)
        /*
        addSubview(lowerVolume)
        addSubview(higherVolume)
        addSubview(volumeSlider)
 */
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        videoTitle.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
        videoTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        currentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        currentTimeLabel.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: 32).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        durationLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        durationLabel.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: 32).isActive = true
        
        videoSlider.leadingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor).isActive = true
        videoSlider.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: -8).isActive = true
        videoSlider.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: 32).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true

        
        previousVideoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        previousVideoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        previousVideoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        previousVideoButton.topAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 32).isActive = true
        
        pauseButton.topAnchor.constraint(equalTo: videoSlider.bottomAnchor, constant: 32).isActive = true
        pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nextVideoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nextVideoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextVideoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        nextVideoButton.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 32).isActive = true
    }
}
