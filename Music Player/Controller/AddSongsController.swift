//
//  AddSongsController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-22.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class AddSongsController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.register(SongCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        if Storage.fileExists("favouriteSongs", in: .documents) {
            videos = Storage.retrieve("favouriteSongs", from: .documents, as: [Video].self)
        }
        
        navigationItem.title = "Add Songs"
    }
    
    let cellId = "cellId"
    var videos = [Video]()
    var playlistIndex: Int!
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
        setConstraints()
    }
    
    let tableView: BaseTableView = {
        let tb = BaseTableView()
        return tb
    }()
    
    private func setConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension AddSongsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SongCell
        cell.delegate = self
        cell.becomeFirstResponder()
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.songTitle.text = videos[indexPath.row].title
        cell.channelLabel.text = videos[indexPath.row].channel
        cell.addSongButton.setTitle("➕", for: .normal)
        let videoThumbnailURL = URL(string: videos[indexPath.row].thumbnailURL)
        let data = try? Data(contentsOf: videoThumbnailURL!)
        if data != nil {
            cell.imageView?.image = UIImage(data: data!)
        }
        return cell
    }
}


//MARK: Song cell delegate
extension AddSongsController: SongCellDelegate {
    func addSongButtonPressed(index: Int) {
        //Add song to playlist and update number of items
        if Storage.fileExists("playlists", in: .documents) {
            var playlists = Storage.retrieve("playlists", from: .documents, as: [Playlist].self)
            playlists[playlistIndex].videos.append(videos[index])
            playlists[playlistIndex].numOfItems = videos.count
            Storage.store(playlists, to: .documents, as: "playlists")
        }
    }
}

