//
//  Season.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class Season {
    var id: Int
    var name: String
    var posterPath: String
    var overview: String
    var airDate: String
    var episodeCount: Int
    var seasonNumber: Int
    
    init() {
        self.id = 0
        self.name = ""
        self.posterPath = ""
        self.overview = ""
        self.airDate = ""
        self.episodeCount = 0
        self.seasonNumber = 0
    }
    
    init(id: Int, name: String, posterPath: String, overview: String, airDate: String, episodeCount: Int, seasonNumber: Int) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.overview = overview
        self.airDate = airDate
        self.episodeCount = episodeCount
        self.seasonNumber = seasonNumber
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  name: jsonObject["name"].stringValue,
                  posterPath: jsonObject["poster_path"].stringValue,
                  overview: jsonObject["overview"].stringValue,
                  airDate: jsonObject["air_date"].stringValue,
                  episodeCount: jsonObject["episode_count"].intValue,
                  seasonNumber: jsonObject["season_number"].intValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Season] {
        var models = [Season]()
        for jsonObject in jsonArray {
            models.append(Season.init(fromJSONObject: jsonObject))
        }
        
        return models
    }
}
