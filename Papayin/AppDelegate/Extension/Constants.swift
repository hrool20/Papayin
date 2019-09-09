//
//  Constant.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/5/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

class Constants {
    static let apiKey = "752cd23fdb3336557bf3d8724e115570"
    
    struct Url {
        private static let url: String = "https://api.themoviedb.org"
        static let imageUrl: String = "https://image.tmdb.org/t/p/original"
        static let thumbnailUrl: String = "https://img.youtube.com/vi"
        static var thirdVersionUrl: String {
            return "\(self.url)/3"
        }
    }
    struct Header {
        static let applicationJSON: String = "application/json"
    }
    struct Keys {
        static let genres: String = "genres"
        static let movieGenres: String = "movieGenres"
        static let tvShowGenres: String = "tvShowGenres"
        static let apiKey: String = "752cd23fdb3336557bf3d8724e115570"
        static let token: String = "token"
    }
}
