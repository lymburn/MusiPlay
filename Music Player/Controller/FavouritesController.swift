//
//  FavouritesController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-21.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class FavouritesController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        tableView.register(SongCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Favourites"
        if Storage.fileExists("favouriteSongs", in: .documents) {
            videos = Storage.retrieve("favouriteSongs", from: .documents, as: [Video].self)
        }
    }
    
    let cellId = "cellId"
    var videos = [Video]()
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
        view.addSubview(shuffleButton)
        super.setupMenuBar(iconName: "Favourites")
        
        setConstraints()
    }
    
    let tableView: BaseTableView = {
        let tb = BaseTableView()
        return tb
    }()
    
    let shuffleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Shuffle", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(shuffleButtonPressed), for: .touchDown)
        return button
    }()
    
    @objc func shuffleButtonPressed() {
        //Pick a random song and play it
        let upper = UInt32(videos.count - 1)
        let randomIndex = arc4random_uniform(upper)
        let playerController = SongPlayerController()
        playerController.videoIndex = Int(randomIndex)
        playerController.videos = videos
        playerController.shuffleMode = true
        self.navigationController?.pushViewController(playerController, animated: false)
    }
    
    private func setConstraints() {
        shuffleButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        shuffleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        shuffleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        shuffleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: shuffleButton.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension FavouritesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SongCell
        cell.becomeFirstResponder()
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.songTitle.text = videos[indexPath.row].title
        cell.channelLabel.text = videos[indexPath.row].channel
        cell.addSongButton.isUserInteractionEnabled = false
        cell.addSongButton.setTitle("", for: .normal)
        let videoThumbnailURL = URL(string: videos[indexPath.row].thumbnailURL)
        let data = try? Data(contentsOf: videoThumbnailURL!)
        cell.imageView?.image = UIImage(data: data!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerController = SongPlayerController()
        playerController.videoIndex = indexPath.row
        playerController.videos = videos
        self.navigationController?.pushViewController(playerController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            //Remove video from storage and update
            videos.remove(at: indexPath.row)
            Storage.store(videos, to: .documents, as: "favouriteSongs")
            tableView.reloadData()
        }
    }
}
