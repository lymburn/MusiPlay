//
//  File.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-18.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import YouTubePlayer
import WebKit

class SongPlayerController : UIViewController {
    var videoId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Player"
        view.backgroundColor = UIColor.white
        setupViews()
        //Settings for video player
        let playerVars = ["controls": "1", "playsinline": "1", "autohide": "1", "showinfo": "0", "autoplay": "0", "fs": "1", "rel": "0", "loop": "0", "enablejsapi": "1", "modestbranding": "1"]
        videoPlayerView.playerVars = playerVars as YouTubePlayerView.YouTubePlayerParameters
        videoPlayerView.delegate = self
        videoPlayerView.loadVideoID(videoId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SongPlayerController.playInBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    
    @objc func playInBackground () {
        DispatchQueue.main.async {
            self.videoPlayerView.play()
        }
        
    }
    
    let videoPlayerView: YouTubePlayerView = {
        let view = YouTubePlayerView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let controlsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupViews() {
        view.addSubview(videoPlayerView)
        view.addSubview(controlsView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        videoPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        /* 16/9 aspect ratio */
        let height = view.frame.size.height/2
        videoPlayerView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controlsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        controlsView.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor).isActive = true
    }
    
}

extension SongPlayerController : YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("player ready")
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {(Timer) in self.videoPlayerView.play()})
    }
}
