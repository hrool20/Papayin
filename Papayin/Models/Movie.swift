//
//  Movie.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/5/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie {
    var id: Int
    var genres: [Int]
    var title: String
    var originalTitle: String
    var posterPath: String
    var backdropPath: String
    var overview: String
    var releaseDate: String
    var includeVideo: Bool
    var includeAdultContent: Bool
    var popularity: Float
    var voteCount: Int
    var voteAverage: Float
    var originalLanguage: String
    
    init() {
        self.id = 0
        self.genres = []
        self.title = ""
        self.originalTitle = ""
        self.posterPath = ""
        self.backdropPath = ""
        self.overview = ""
        self.releaseDate = ""
        self.includeVideo = false
        self.includeAdultContent = false
        self.popularity = 0.000
        self.voteCount = 0
        self.voteAverage = 0.000
        self.originalLanguage = ""
    }
    
    init(id: Int, genres: [Int], title: String, originalTitle: String, posterPath: String, backdropPath: String, overview: String, releaseDate: String, includeVideo: Bool, includeAdultContent: Bool, popularity: Float, voteCount: Int, voteAverage: Float, originalLanguage: String) {
        self.id = id
        self.genres = genres
        self.title = title
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.includeVideo = includeVideo
        self.includeAdultContent = includeAdultContent
        self.popularity = popularity
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.originalLanguage = originalLanguage
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        var genres = [Int]()
        for genre in jsonObject["genre_ids"].arrayValue {
            genres.append(genre.intValue)
        }
        self.init(id: jsonObject["id"].intValue,
                  genres: genres,
                  title: jsonObject["title"].stringValue,
                  originalTitle: jsonObject["original_title"].stringValue,
                  posterPath: jsonObject["poster_path"].stringValue,
                  backdropPath: jsonObject["backgrop_path"].stringValue,
                  overview: jsonObject["overview"].stringValue,
                  releaseDate: jsonObject["release_date"].stringValue,
                  includeVideo: jsonObject["video"].boolValue,
                  includeAdultContent: jsonObject["adult"].boolValue,
                  popularity: jsonObject["popularity"].floatValue,
                  voteCount: jsonObject["vote_count"].intValue,
                  voteAverage: jsonObject["vote_average"].floatValue,
                  originalLanguage: jsonObject["original_language"].stringValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Movie] {
        var models = [Movie]()
        for jsonObject in jsonArray {
            models.append(Movie.init(fromJSONObject: jsonObject))
        }
        
        return models
    }
}
