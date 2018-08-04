//
//  ViewController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TrendingController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Trending"
        
        setupViews()
        
        videoModel.fetchSongs(part: "snippet", category: "10", nextPage: false)
        videoModel.delegate = self
        
        tableView.register(SongCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        if Storage.fileExists("favouriteSongs", in: .documents) {
            favouriteSongs = Storage.retrieve("favouriteSongs", from: .documents, as: [Video].self)
        }
    }
    
    let videoModel = VideoModel()
    var videos = [Video]()
    let cellId = "cellId"
    var favouriteSongs = [Video]()
    var activityIndicator : NVActivityIndicatorView!
    
    let tableView : BaseTableView = {
        let tableView = BaseTableView()
        return tableView
    }()

    var loadingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //Loading animation
    private func setActivityIndicator() {
        let size = view.bounds.width/6
        let frame = CGRect(x: view.center.x - size/2.0, y: view.center.y - size/2, width: size, height: size)
        activityIndicator = NVActivityIndicatorView(frame: frame, type: .audioEqualizer, color: UIColor.blue)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(loadingView)
        updateViewConstraints()
        setActivityIndicator()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension TrendingController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SongCell
        cell.delegate = self
        cell.index = indexPath.row
        cell.selectionStyle = .none
        cell.songTitle.text = videos[indexPath.row].title
        cell.channelLabel.text = videos[indexPath.row].channel
        let videoThumbnailURL = URL(string: videos[indexPath.row].thumbnailURL)
        let data = try? Data(contentsOf: videoThumbnailURL!)
        cell.imageView?.image = UIImage(data: data!)
        
        //Set the add song button depending on if the song is favourited
        let videosSet = Set<Video>(videos)
        let favouritesSet = Set<Video>(favouriteSongs)
        let intersect = videosSet.intersection(favouritesSet)
        //Mark songs that intersect as favourited
        for video in intersect {
            if video.videoId == videos[indexPath.row].videoId {
                cell.songAdded = true
                break
            } else {
                cell.songAdded = false
            }
        }
        let addSongButtonText = cell.songAdded ? "✔️" : "➕"
        cell.addSongButton.setTitle(addSongButtonText, for: .normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerController = SongPlayerController()
        playerController.videoIndex = indexPath.row
        playerController.videos = videos
        self.navigationController?.pushViewController(playerController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Fetch more videos when scrolled to bottom
        let lastElement = videos.count - 1
        if indexPath.row == lastElement {
            print("fetching more music")
            videoModel.fetchMoreSongs(search: false, query: "")
        }
    }
}

//MARK: Video model delegate
extension TrendingController: VideoModelDelegate {
    func dataReady() {
        videos = videoModel.videos
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.loadingView.alpha = 0
            self.activityIndicator.stopAnimating()
        }
    }
}

//MARK: Song cell delegate
extension TrendingController: SongCellDelegate {
    func addSongButtonPressed(index: Int) {
        //Local song storage
        var favourites = [Video]()
        if Storage.fileExists("favouriteSongs", in: .documents) {
            favourites = Storage.retrieve("favouriteSongs", from: .documents, as: [Video].self)
            favourites.append(videos[index])
            Storage.store(favourites, to: .documents, as: "favouriteSongs")
        } else {
            favourites.append(videos[index])
            Storage.store(favourites, to: .documents, as: "favouriteSongs")
        }
    }
}
