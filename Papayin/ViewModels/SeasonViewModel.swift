//
//  SeasonViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct SeasonViewModel {
    let season: Season
    let image: String
    let name: String
    let overview: String
    let episodeNumber: String
    let airDate: String
    
    init(season: Season) {
        self.season = season
        self.image = "\(Constants.Url.imageUrl)/\(season.posterPath)"
        self.name = season.name
        self.overview = season.overview
        self.episodeNumber = "\(season.episodeCount)"
        self.airDate = season.airDate
    }
}
