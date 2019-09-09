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
    var genreIds: [Int]
    var genres: [Genre]
    var productionCompanies: [Company]
    var productionCountries: [Country]
    var title: String
    var originalTitle: String
    var posterPath: String
    var backdropPath: String
    var overview: String
    var releaseDate: String
    var includeVideo: Bool
    var includeAdultContent: Bool
    var popularity: Float
    var revenue: Int
    var runtime: Double
    var budget: Int
    var voteCount: Int
    var voteAverage: Float
    var originalLanguage: String
    
    init() {
        self.id = 0
        self.genreIds = []
        self.genres = []
        self.productionCompanies = []
        self.productionCountries = []
        self.title = ""
        self.originalTitle = ""
        self.posterPath = ""
        self.backdropPath = ""
        self.overview = ""
        self.releaseDate = ""
        self.includeVideo = false
        self.includeAdultContent = false
        self.popularity = 0.000
        self.revenue = 0
        self.runtime = 0.000
        self.budget = 0
        self.voteCount = 0
        self.voteAverage = 0.000
        self.originalLanguage = ""
    }
    
    init(id: Int, genreIds: [Int], genres: [Genre], productionCompanies: [Company], productionCountries: [Country], title: String, originalTitle: String, posterPath: String, backdropPath: String, overview: String, releaseDate: String, includeVideo: Bool, includeAdultContent: Bool, popularity: Float, revenue: Int, runtime: Double, budget: Int, voteCount: Int, voteAverage: Float, originalLanguage: String) {
        self.id = id
        self.genreIds = genreIds
        self.genres = genres
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.title = title
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.includeVideo = includeVideo
        self.includeAdultContent = includeAdultContent
        self.popularity = popularity
        self.revenue = revenue
        self.runtime = runtime
        self.budget = budget
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.originalLanguage = originalLanguage
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        var genreIds = [Int]()
        for genreId in jsonObject["genre_ids"].arrayValue {
            genreIds.append(genreId.intValue)
        }
        self.init(id: jsonObject["id"].intValue,
                  genreIds: genreIds,
                  genres: Genre.buildCollection(fromJSONArray: jsonObject["genres"].arrayValue),
                  productionCompanies: Company.buildCollection(fromJSONArray: jsonObject["production_companies"].arrayValue),
                  productionCountries: Country.buildCollection(fromJSONArray: jsonObject["production_countries"].arrayValue),
                  title: jsonObject["title"].stringValue,
                  originalTitle: jsonObject["original_title"].stringValue,
                  posterPath: jsonObject["poster_path"].stringValue,
                  backdropPath: jsonObject["backgrop_path"].stringValue,
                  overview: jsonObject["overview"].stringValue,
                  releaseDate: jsonObject["release_date"].stringValue,
                  includeVideo: jsonObject["video"].boolValue,
                  includeAdultContent: jsonObject["adult"].boolValue,
                  popularity: jsonObject["popularity"].floatValue,
                  revenue: jsonObject["revenue"].intValue,
                  runtime: jsonObject["runtime"].doubleValue,
                  budget: jsonObject["budget"].intValue,
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
