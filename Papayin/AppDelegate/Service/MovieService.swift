//
//  MovieService.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/6/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieService {
    static let shared = MovieService()
    
    func getMovies(successCompletion: @escaping ([Movie]) -> Void,
                   failureCompletion: @escaping (Error) -> Void) -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyy-MM-dd"
        
        let parameters = [
            "api_key": Constants.apiKey,
            "release_date.lte": dateFormatter.string(from: Date())
        ]
        
        ResponseHelper.GET(url: "\(Constants.Url.thirdVersionUrl)/discover/movie", parameters: parameters, successCompletion: { (response) in
            successCompletion(Movie.buildCollection(fromJSONArray: response["results"].arrayValue))
        }) { (error) in
            failureCompletion(error)
        }
    }
    
    func getMovieDetail(movieId: Int,
                        successCompletion: @escaping (Movie) -> Void,
                        failureCompletion: @escaping (Error) -> Void) -> Void {
        let parameters = [
            "api_key": Constants.apiKey
        ]
        
        ResponseHelper.GET(url: "\(Constants.Url.thirdVersionUrl)/movie/\(movieId)", parameters: parameters, successCompletion: { (response) in
            successCompletion(Movie.init(fromJSONObject: response))
        }) { (error) in
            failureCompletion(error)
        }
    }
    
    func getTVShows(successCompletion: @escaping ([TVShow]) -> Void,
                    failureCompletion: @escaping (Error) -> Void) -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let parameters = [
            "api_key": Constants.apiKey,
            "first_air_date.lte": dateFormatter.string(from: Date())
        ]
        
        ResponseHelper.GET(url: "\(Constants.Url.thirdVersionUrl)/discover/tv", parameters: parameters, successCompletion: { (response) in
            successCompletion(TVShow.buildCollection(fromJSONArray: response["results"].arrayValue))
        }) { (error) in
            failureCompletion(error)
        }
    }
}
