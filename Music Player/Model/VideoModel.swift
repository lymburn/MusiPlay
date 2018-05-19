//
//  Video.swift
//  Music Player
//
//  Created by Eugene Lu on 2018-05-17.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit

struct Video {
    let title: String
    let thumbnailURL: String
    let channel: String
    let videoId: String
}

protocol VideoModelDelegate: class {
    //Indicate when the songs are requested
    func dataReady()
}

class VideoModel : NSObject {
    let apiKey = "AIzaSyCKx6f39vFN84qnGM6x2s_tyPzLwoN2cnA"
    var videos = [Video]()
    weak var delegate: VideoModelDelegate?
    
    func getTrendingSongs() {
        //Fetch trending music videos from Youtube API
        //Parameters
        let part = "snippet"
        let chart = "mostPopular"
        let videoCategoryId = "10"
        let maxResults = 20
        
        let youtubeApi = "https://www.googleapis.com/youtube/v3/videos?part=\(part)&chart=\(chart)&maxResults=\(maxResults)&videoCategoryId=\(videoCategoryId)&key=\(apiKey)"
        guard let url = URL(string: youtubeApi) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : AnyObject] {
                    for videoObject in json["items"] as! NSArray {
                        self.parseJSON(video: videoObject)
                    }
                    //Indicate data is fetched
                    if self.delegate != nil {
                        self.delegate!.dataReady()
                    }
                }
            }
            catch {
                print("json error: \(error)")
            }
            
        }.resume()
    }
    
    //Get video title, thumbnail, and channel name
    private func parseJSON(video: Any) {
        let videoInfo = video as! [String: AnyObject]
        let videoId = videoInfo["id"] as! String
        let snippet = videoInfo["snippet"] as! [String: AnyObject]
        let videoTitle = snippet["title"] as! String
        let channelTitle = snippet["channelTitle"] as! String
        let thumbnails = snippet["thumbnails"] as! [String: AnyObject]
        let defaultSizeThumbnail = thumbnails["default"] as! [String: AnyObject]
        let thumbnailURL = defaultSizeThumbnail["url"] as! String
        videos.append(Video(title: videoTitle, thumbnailURL: thumbnailURL, channel: channelTitle, videoId: videoId))
    }
}
