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
import NVActivityIndicatorView

class SongPlayerController : UIViewController{
    var videoIndex: Int? = nil
    var videos : [Video]? = nil
    var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Player"
        view.backgroundColor = UIColor.white
        setupViews()
        //Settings for video player
        let playerVars = ["controls": "0", "playsinline": "1", "autohide": "1", "showinfo": "0", "autoplay": "0", "fs": "0", "rel": "0", "loop": "0", "enablejsapi": "1", "modestbranding": "1"]
        videoPlayerView.playerVars = playerVars as YouTubePlayerView.YouTubePlayerParameters
        videoPlayerView.delegate = self
        
        guard let videoIndex = videoIndex else {return}
        guard let videos = videos else {return}
        videoPlayerView.loadVideoID(videos[videoIndex].videoId)
        
        setActivityIndicator()
        NotificationCenter.default.addObserver(self, selector: #selector(SongPlayerController.playInBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc func playInBackground () {
        //if videoPlayerView.playerState != YouTubePlayerState.Buffering{
        print("Hi")
        print (videoPlayerView.playerState)
            self.videoPlayerView.play()
        //}
    }
    
    //Loading animation
    private func setActivityIndicator() {
        let size = view.bounds.width/6
        let frame = CGRect(x: view.center.x - size/2, y: view.bounds.height/4, width: size, height: size)
        activityIndicator = NVActivityIndicatorView(frame: frame, type: .ballSpinFadeLoader, color: UIColor.white)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    let videoPlayerView: YouTubePlayerView = {
        let view = YouTubePlayerView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let controlsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupViews() {
        view.addSubview(videoPlayerView)
        view.addSubview(controlsView)
        view.addSubview(loadingView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        videoPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoPlayerView.heightAnchor.constraint(equalToConstant: view.frame.size.height/2).isActive = true
        
        controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controlsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        controlsView.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor).isActive = true
        
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: view.frame.size.height/2).isActive = true
    }
}

extension SongPlayerController : YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("player ready")
        videoPlayerView.play()

        //Remove loading spinner after youtube signs are gone
        Timer.scheduledTimer(withTimeInterval: 6, repeats: false, block: {(Timer) in
            self.loadingView.backgroundColor = UIColor.clear
            self.activityIndicator.stopAnimating()
        })
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        print(playerState)
        if playerState == YouTubePlayerState.Ended {
            //Increment video index
            guard var videoIndex = videoIndex else {return}
            guard let videos = videos else {return}
            videoIndex += 1
            //Play next video if index is less than array size
            if videoIndex < videos.count {
                videoPlayerView.loadVideoID(videos[videoIndex].videoId)
            }
        }
        
    }
}
