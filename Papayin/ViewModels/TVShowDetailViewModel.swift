//
//  TVShowDetailViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct TVShowDetailViewModel {
    var tvShow: TVShow
    var image: String
    var name: String
    var categories: String
    var overview: String
    var cast: [Cast]
    var seasons: [Season]
    
    init(tvShow: TVShow) {
        self.tvShow = tvShow
        self.image = "\(Constants.Url.imageUrl)/\(tvShow.posterPath)"
        self.name = tvShow.name
        var genreAux = ""
        for i in 0..<tvShow.genres.count {
            let genre = tvShow.genres[i]
            genreAux.append((i != tvShow.genres.count - 1) ? "\(genre.name), " : "\(genre.name)")
        }
        self.categories = genreAux
        self.overview = tvShow.overview
        self.cast = tvShow.cast
        self.seasons = tvShow.seasons
    }
}
