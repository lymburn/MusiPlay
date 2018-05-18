//
//  ViewController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-16.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SongsController: UITableViewController, VideoModelDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Charts"
        setupTableView()
        setupMenuBar()
        videoModel.getTrendingSongs()
        videoModel.delegate = self
    }
    
    let videoModel = VideoModel()
    var videos = [Video]()
    let cellId = "cellId"
    
    func dataReady() {
        videos = videoModel.videos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.register(SongCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 110
        tableView.showsVerticalScrollIndicator = false
        //Edge to edge separator lines
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        //Set constraints
        menuBar.bottomAnchor.constraint(equalTo: tableView.layoutMarginsGuide.bottomAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SongCell
        cell.selectionStyle = .none
        cell.songTitle.text = videos[indexPath.row].title
        cell.channelLabel.text = videos[indexPath.row].channel
        let videoThumbnailURL = URL(string: videos[indexPath.row].thumbnailURL)
        let data = try? Data(contentsOf: videoThumbnailURL!)
        cell.imageView?.image = UIImage(data: data!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerController = SongPlayerController()
        self.navigationController?.pushViewController(playerController, animated: false)
    }
}

