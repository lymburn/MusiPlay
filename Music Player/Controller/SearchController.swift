//
//  SearchController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-18.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(searchBar)
        setConstraints()
    }
    
    let searchBar : UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private func setConstraints() {
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
