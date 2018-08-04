//
//  TabController.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-08-04.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white

        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        trendingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        playlistVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 3)
        
        let controllers = [trendingVC, searchVC, playlistVC, favoritesVC]
        self.viewControllers = controllers
    }
    
    let favoritesVC = UINavigationController(rootViewController: FavouritesController())
    let trendingVC = UINavigationController(rootViewController: TrendingController())
    let searchVC = UINavigationController(rootViewController: SearchController())
    let playlistVC = UINavigationController(rootViewController: PlaylistController())
}
