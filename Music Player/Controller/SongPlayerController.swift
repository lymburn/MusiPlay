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
        let playerVars = ["controls": "0", "playsinline": "1", "autohide": "1", "showinfo": "0", "autoplay": "1", "fs": "0", "rel": "0", "loop": "0", "enablejsapi": "1", "modestbranding": "1"]
        videoPlayerView.playerVars = playerVars as YouTubePlayerView.YouTubePlayerParameters
        videoPlayerView.delegate = self
        
        guard let videoIndex = videoIndex else {return}
        guard let videos = videos else {return}
        videoPlayerView.clear()
        videoPlayerView.loadVideoID(videos[videoIndex].videoId)
        
        setActivityIndicator()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParentViewController {
            videoPlayerView.stop()
            videoPlayerView.clear()
        }
    }
    
    //Loading animation
    private func setActivityIndicator() {
        let size = view.bounds.width/6
        let frame = CGRect(x: view.center.x - size/2, y: view.bounds.height*0.3, width: size, height: size)
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
    
    lazy var controlsView: PlayerControlsView = {
        let view = PlayerControlsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.videoSlider.addTarget(self, action: #selector(videoSliderValueDidChange), for: .valueChanged)
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
        
        controlsView.videoTitle.text = videos?[videoIndex!].title
        setupConstraints()
    }
    
    private func setupConstraints() {
        videoPlayerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        videoPlayerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoPlayerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoPlayerView.heightAnchor.constraint(equalToConstant: view.frame.size.height*0.6).isActive = true
        
        controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        controlsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        controlsView.topAnchor.constraint(equalTo: videoPlayerView.bottomAnchor).isActive = true
        
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: view.frame.size.height*0.6).isActive = true
    }
}

extension SongPlayerController : YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("player ready")
        videoPlayerView.play()
        setVideoDuration(for: videoPlayerView.getDuration()!)
        setCurrentTime()
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
                videoPlayerView.clear()
                controlsView.videoTitle.text = videos[videoIndex].title
                videoPlayerView.loadVideoID(videos[videoIndex].videoId)
            }
        }
        
        if playerState == YouTubePlayerState.Playing {
            loadingView.backgroundColor = UIColor.clear
            activityIndicator.stopAnimating()
        }
    }
}

//MARK: Controls functions
extension SongPlayerController {
    fileprivate func getFormattedTime(_ time: String) -> String {
        //Set formatted duration
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        
        let newTime = (time as NSString).integerValue
        var formattedString = formatter.string(from: TimeInterval(newTime))!
        
        //Add 0's if time is less than 10 seconds, 1 minute, and 10 minutes
        if newTime < 10 {
            formattedString = "00:0" + formattedString
        } else if newTime < 60 {
            formattedString = "00:" + formattedString
        } else if newTime < 600 {
            formattedString = "0" + formattedString
        }
        return formattedString
    }
    
    fileprivate func setVideoDuration(for duration: String) {
        controlsView.durationLabel.text = getFormattedTime(duration)
        
        //Set max value for slider
        let floatDuration = (duration as NSString).floatValue
        self.controlsView.videoSlider.maximumValue = floatDuration
    }
    
    fileprivate func setCurrentTime() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) {(Timer) in
            let currentTime = self.videoPlayerView.getCurrentTime()!
            let formattedTime = self.getFormattedTime(currentTime)
            self.controlsView.currentTimeLabel.text = formattedTime
            
            //Set slider value
            let floatTime = (currentTime as NSString).floatValue
            self.controlsView.videoSlider.value = floatTime
        }
    }
    
    @objc func videoSliderValueDidChange (){
        videoPlayerView.seekTo(controlsView.videoSlider.value, seekAhead: true)
    }
}
