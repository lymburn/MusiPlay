//
//  PlaylistController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-22.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class PlaylistController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(PlaylistCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Playlist"
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlaylistButton)), animated: true)
        
        if Storage.fileExists("playlists", in: .documents) {
            playlists = Storage.retrieve("playlists", from: .documents, as: [Playlist].self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Reload songs data
        if Storage.fileExists("playlists", in: .documents) {
            playlists = Storage.retrieve("playlists", from: .documents, as: [Playlist].self)
        }
        tableView.reloadData()
    }
    
    let cellId = "cellId"
    var playlists = [Playlist]()
    
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
        super.setupMenuBar(iconName: "Playlist")
        setConstraints()
    }
    
    let tableView: BaseTableView = {
        let tb = BaseTableView()
        return tb
    }()
    
    @objc func addPlaylistButton() {
        //Alert to create new playlist
        let newPlaylistController = UIAlertController(title: "New Playlist", message: "", preferredStyle: .alert)
        newPlaylistController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Playlist name"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            //Save new playlist
            let nameTextField = newPlaylistController.textFields![0] as UITextField
            let newPlaylist = Playlist(videos: [Video](), title: nameTextField.text!, numOfItems: 0)
            self.storeNewPlaylist(playlist: newPlaylist)
            self.tableView.reloadData()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        newPlaylistController.addAction(saveAction)
        newPlaylistController.addAction(cancelAction)
        
        present(newPlaylistController, animated: true, completion: nil)
    }
    
    private func storeNewPlaylist(playlist: Playlist) {
        if Storage.fileExists("playlists", in: .documents) {
            playlists = Storage.retrieve("playlists", from: .documents, as: [Playlist].self)
            playlists.append(playlist)
            Storage.store(playlists, to: .documents, as: "playlists")
        } else {
            playlists.append(playlist)
            Storage.store(playlists, to: .documents, as: "playlists")
        }
    }

    
    private func setConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension PlaylistController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlaylistCell
        cell.becomeFirstResponder()
        cell.selectionStyle = .none
        cell.title.text = playlists[indexPath.row].title
        cell.itemCount.text = "\(playlists[indexPath.row].numOfItems) items"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playlistSongsController = PlaylistSongsController()
        playlistSongsController.playlistName = playlists[indexPath.row].title
        playlistSongsController.playlistIndex = indexPath.row
        self.navigationController?.pushViewController(playlistSongsController, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            playlists.remove(at: indexPath.row)
            Storage.store(playlists, to: .documents, as: "playlists")
            tableView.reloadData()
        }
    }
}
