//
//  SearchController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-18.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SearchController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search"
        view.backgroundColor = UIColor.white
        searchBar.delegate = self
        videoModel.delegate = self
        
        tableView.register(SongCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        //End editing when tapping outside search bar
        tableView.addGestureRecognizer(tap)
        
        if Storage.fileExists("favouriteSongs", in: .documents) {
            favouriteSongs = Storage.retrieve("favouriteSongs", from: .documents, as: [Video].self)
        }
    }
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    let videoModel = VideoModel()
    var videos = [Video]()
    let cellId = "cellId"
    var query: String? = nil
    var favouriteSongs = [Video]()
    
    @objc func dismissKeyboard() {
        searchBar.endEditing(true)
    }
    
    override func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        super.setupMenuBar(iconName: "Search")
        setConstraints()
    }
    
    let tableView: BaseTableView = {
        let tb = BaseTableView()
        return tb
    }()
    
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private func setConstraints() {
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: UISearchBar delegates methods
extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tap.isEnabled = false //Remove tap gesture
        searchBar.endEditing(true)
        //Fetch songs of related search
        if searchBar.text != "" && searchBar.text != nil {
            query = searchBar.text!
            //Replace spaces with + for youtube queries
            query = query!.replacingOccurrences(of: " ", with: "+")
            videoModel.fetchNewSearchResults(part: "snippet", nextPage: false, query: query!)
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.text = ""
        searchBar.endEditing(true)
    }
}

//MARK: Table view delegate and data source
extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SongCell
        cell.becomeFirstResponder()
        cell.selectionStyle = .none
        cell.index = indexPath.row
        cell.delegate = self
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
        if intersect.count > 0 {
            for video in intersect {
                if video.videoId == videos[indexPath.row].videoId {
                    cell.songAdded = true
                    break
                } else {
                    cell.songAdded = false
                }
            }
        } else {
            cell.songAdded = false
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
            guard let query = query else {return}
            videoModel.fetchMoreSongs(search: true, query: query)
        }
    }
}
//MARK: Video model delegate
extension SearchController: VideoModelDelegate {
    func dataReady() {
        videos = videoModel.videos
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: Song cell delegate
extension SearchController: SongCellDelegate {
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
