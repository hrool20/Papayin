//
//  TVShow.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/5/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class TVShow {
    var id: Int
    var genreIds: [Int]
    var genres: [Genre]
    var name: String
    var originalName: String
    var posterPath: String
    var backdropPath: String
    var overview: String
    var firstAirDate: String
    var popularity: Float
    var voteCount: Int
    var voteAverage: Float
    var originaLanguage: String
    
    init() {
        self.id = 0
        self.genreIds = []
        self.genres = []
        self.name = ""
        self.originalName = ""
        self.posterPath = ""
        self.backdropPath = ""
        self.overview = ""
        self.firstAirDate = ""
        self.popularity = 0.000
        self.voteCount = 0
        self.voteAverage = 0.000
        self.originaLanguage = ""
    }
    
    init(id: Int, genreIds: [Int], genres: [Genre], name: String, originalName: String, posterPath: String, backdropPath: String, overview: String, firstAirDate: String, popularity: Float, voteCount: Int, voteAverage: Float, originaLanguage: String) {
        self.id = id
        self.genreIds = genreIds
        self.genres = genres
        self.name = name
        self.originalName = originalName
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.popularity = popularity
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.originaLanguage = originaLanguage
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        var genreIds = [Int]()
        for genreId in jsonObject["genre_ids"].arrayValue {
            genreIds.append(genreId.intValue)
        }
        self.init(id: jsonObject["id"].intValue,
                  genreIds: genreIds,
                  genres: Genre.buildCollection(fromJSONArray: jsonObject["genres"].arrayValue),
                  name: jsonObject["name"].stringValue,
                  originalName: jsonObject["original_name"].stringValue,
                  posterPath: jsonObject["poster_path"].stringValue,
                  backdropPath: jsonObject["backdrop_path"].stringValue,
                  overview: jsonObject["overview"].stringValue,
                  firstAirDate: jsonObject["first_air_date"].stringValue,
                  popularity: jsonObject["popularity"].floatValue,
                  voteCount: jsonObject["vote_count"].intValue,
                  voteAverage: jsonObject["vote_average"].floatValue,
                  originaLanguage: jsonObject["original_language"].stringValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [TVShow] {
        var models = [TVShow]()
        for jsonObject in jsonArray {
            models.append(TVShow.init(fromJSONObject: jsonObject))
        }
        
        return models
    }
}
