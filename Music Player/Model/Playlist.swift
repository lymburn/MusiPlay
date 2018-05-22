//
//  Playlist.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-22.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

struct Playlist: Codable {
    
    var videos: [Video]
    var title: String
    var numOfItems: Int
}
