//
//  GenreService.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/6/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

enum GenreServiceType: String {
    case movie = "/movie"
    case tvShow = "/tv"
    case none = ""
}

class GenreService {
    static let shared = GenreService()
    
    func getGenres(from type: GenreServiceType,
                   successCompletion: @escaping ([Genre]) -> Void,
                   failureCompletion: @escaping (Error) -> Void) -> Void {
        let parameers: [String: Any] = [
            "api_key": Constants.apiKey
        ]
        
        ResponseHelper.GET(url: "\(Constants.Url.thirdVersionUrl)/genre\(type.rawValue)/list", parameters: parameers, successCompletion: { (response) in
            successCompletion(Genre.buildCollection(fromJSONArray: response["genres"].arrayValue))
        }) { (error) in
            failureCompletion(error)
        }
    }
}
