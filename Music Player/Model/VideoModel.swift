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
    var nextPageToken : String? = nil
    weak var delegate: VideoModelDelegate?
    
    //Fetching parameters
    private let maxResults = 25
    
    func fetchSongs(part: String, category: String, nextPage: Bool) {
        //Fetch trending music videos from Youtube API
        var youtubeApi = String()
        
        //Looking for trending music
        if nextPage {
            //Fetch videos from next page if token not nil
            guard let nextPageToken = nextPageToken else {return}
            youtubeApi = "https://www.googleapis.com/youtube/v3/videos?part=\(part)&chart=mostPopular&maxResults=\(maxResults)&videoCategoryId=\(category)&pageToken=\(nextPageToken)&key=\(apiKey)"
        } else {
            youtubeApi = "https://www.googleapis.com/youtube/v3/videos?part=\(part)&chart=mostPopular&maxResults=\(maxResults)&videoCategoryId=\(category)&key=\(apiKey)"
        }
        
        guard let url = URL(string: youtubeApi) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : AnyObject] {
                    self.nextPageToken = json["nextPageToken"] as? String
                    for videoObject in json["items"] as! NSArray {
                        self.parseTrendingJSON(video: videoObject)
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
    
    func fetchMoreSongs(search: Bool, query: String) {
        //Fetch songs from next page
        if !search {
            fetchSongs(part: "snippet", category: "10", nextPage: true)
        } else {
            fetchSearchResults(part: "snippet", nextPage: true, query: query)
        }
    }
    
    func fetchSearchResults(part: String, nextPage: Bool, query:String) {
        //Looking for search results
        var youtubeApi = String()
        if nextPage {
            guard let nextPageToken = nextPageToken else {return}
            youtubeApi = "https://www.googleapis.com/youtube/v3/search?part=\(part)&q=\(query)&pageToken=\(nextPageToken)&maxResults=\(maxResults)&type=video&key=\(apiKey)"
        } else {
            youtubeApi = "https://www.googleapis.com/youtube/v3/search?part=\(part)&q=\(query)&maxResults=\(maxResults)&type=video&key=\(apiKey)"
        }
        
        guard let url = URL(string: youtubeApi) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : AnyObject] {
                    self.nextPageToken = json["nextPageToken"] as? String
                    for videoObject in json["items"] as! NSArray {
                        self.parseSearchJSON(video: videoObject)
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
    
    private func parseSearchJSON(video: Any) {
        let videoInfo = video as! [String: AnyObject]
        let searchId = videoInfo["id"] as! [String: AnyObject]
        let videoId = searchId["videoId"] as! String
        let snippet = videoInfo["snippet"] as! [String: AnyObject]
        let videoTitle = snippet["title"] as! String
        let channelTitle = snippet["channelTitle"] as! String
        let thumbnails = snippet["thumbnails"] as! [String: AnyObject]
        let defaultSizeThumbnail = thumbnails["default"] as! [String: AnyObject]
        let thumbnailURL = defaultSizeThumbnail["url"] as! String
        videos.append(Video(title: videoTitle, thumbnailURL: thumbnailURL, channel: channelTitle, videoId: videoId))
    }
    
    //Get video title, thumbnail, and channel name
    private func parseTrendingJSON(video: Any) {
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
