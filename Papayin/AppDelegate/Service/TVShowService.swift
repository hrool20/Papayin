//
//  TVShowService.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class TVShowService {
    static let shared = TVShowService()
    
    func getTVShows(page: Int,
                    successCompletion: @escaping ([TVShow]) -> Void,
                    failureCompletion: @escaping (Error) -> Void) -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let parameters = [
            "api_key": Constants.apiKey,
            "first_air_date.lte": dateFormatter.string(from: Date()),
            "page": "\(page)"
        ]
        
        ResponseHelper.GET(url: "\(Constants.Url.thirdVersionUrl)/discover/tv", parameters: parameters, successCompletion: { (response) in
            successCompletion(TVShow.buildCollection(fromJSONArray: response["results"].arrayValue))
        }) { (error) in
            failureCompletion(error)
        }
    }
    
    func getTVShowDetail(tvShowId: Int,
                         successCompletion: @escaping (TVShow) -> Void,
                         failureCompletion: @escaping (Error) -> Void) -> Void {
        let parameters = [
            "api_key": Constants.apiKey
        ]
        
        ResponseHelper.GET(url: "\(Constants.Url.thirdVersionUrl)/tv/\(tvShowId)", parameters: parameters, successCompletion: { (response) in
            successCompletion(TVShow.init(fromJSONObject: response))
        }) { (error) in
            failureCompletion(error)
        }
    }
}