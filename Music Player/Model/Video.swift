//
//  Video.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-22.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import Foundation

struct Video: Codable, Hashable {
    let title: String
    let thumbnailURL: String
    let channel: String
    let videoId: String
}
