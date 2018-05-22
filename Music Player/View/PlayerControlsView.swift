//
//  PlayerControlsView.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-20.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import MediaPlayer
import MarqueeLabel

class PlayerControlsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let videoTitle: MarqueeLabel = {
        let label = MarqueeLabel()
        label.font = UIFont(name: label.font.fontName, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.type = .continuous
        label.textAlignment = .center
        label.speed = .rate(40)
        label.fadeLength = 40.0
        label.labelWillBeginScroll()
        return label
    }()
    
    let currentTimeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 13)
        label.text = "00:00"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: label.font.fontName, size: 13)
        label.text = "00:00"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .black
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
        let image = UIImageView(image: UIImage(named: "LowVolume"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let higherVolume: UIImageView = {
        let image = UIImageView(image: UIImage(named: "HighVolume"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let volumeSlider: UISlider = {
        let volume = MPVolumeView()
        var volumeSlider = UISlider()
        if let slider = volume.subviews.first as? UISlider {
            volumeSlider = slider
            volumeSlider.translatesAutoresizingMaskIntoConstraints = false
            volumeSlider.minimumTrackTintColor = UIColor.black
        }
        return volumeSlider
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
        
        addSubview(lowerVolume)
        addSubview(higherVolume)
        addSubview(volumeSlider)
 
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        //Title Constraints
        videoTitle.bottomAnchor.constraint(equalTo: videoSlider.topAnchor, constant: -24).isActive = true
        videoTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        videoTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        //Video time controls
        currentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: previousVideoButton.topAnchor, constant: -24).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        durationLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        durationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        durationLabel.bottomAnchor.constraint(equalTo: nextVideoButton.topAnchor, constant: -24).isActive = true
        
        videoSlider.leadingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor).isActive = true
        videoSlider.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: -8).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: pauseButton.topAnchor, constant: -24).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true

        //Playback controls
        previousVideoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        previousVideoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        previousVideoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        previousVideoButton.bottomAnchor.constraint(equalTo: lowerVolume.topAnchor, constant: -24).isActive = true
        
        pauseButton.bottomAnchor.constraint(equalTo: volumeSlider.topAnchor, constant: -24).isActive = true
        pauseButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pauseButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nextVideoButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nextVideoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextVideoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
        nextVideoButton.bottomAnchor.constraint(equalTo: higherVolume.topAnchor, constant: -24).isActive = true
        
        //Volume controls
        lowerVolume.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44).isActive = true
        lowerVolume.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        lowerVolume.widthAnchor.constraint(equalToConstant: 15).isActive = true
        lowerVolume.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        higherVolume.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44).isActive = true
        higherVolume.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        higherVolume.widthAnchor.constraint(equalToConstant: 15).isActive = true
        higherVolume.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        volumeSlider.leadingAnchor.constraint(equalTo: lowerVolume.trailingAnchor, constant: 24).isActive = true
        volumeSlider.trailingAnchor.constraint(equalTo: higherVolume.leadingAnchor, constant: -24).isActive = true
        volumeSlider.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24).isActive = true
        volumeSlider.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
}
