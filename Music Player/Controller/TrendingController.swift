//
//  ViewController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TrendingController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Trending"
        
        videoModel.fetchSongs(part: "snippet", category: "10", nextPage: false)
        videoModel.delegate = self
        
        tableView.register(SongCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    let videoModel = VideoModel()
    var videos = [Video]()
    let cellId = "cellId"
    
    let tableView : BaseTableView = {
        let tableView = BaseTableView()
        return tableView
    }()
    
    private func setConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
        super.setupMenuBar(iconName: "Trending")
        setConstraints()
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
        
        //Set the add song button depending on if the
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
        print("data ready")
        videos = videoModel.videos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: Song cell delegate
extension TrendingController: SongCellDelegate {
    func addSongButtonPressed(index: Int) {
        //Local song storage
        var favouriteSongs = [Video]()
        if Storage.fileExists("favouriteSongs", in: .documents) {
            favouriteSongs = Storage.retrieve("favouriteSongs", from: .documents, as: [Video].self)
            favouriteSongs.append(videos[index])
        }
        Storage.store(favouriteSongs, to: .documents, as: "favouriteSongs")
    }
}
