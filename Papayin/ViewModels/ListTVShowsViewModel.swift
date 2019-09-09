//
//  ListTVShowsViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct ListTVShowsViewModel {
    let image: String
    let title: String
    let releaseDate: String
    let categories: String
    let votesAverage: String
    
    init(tvShow: TVShow) {
        self.image = "\(Constants.Url.imageUrl)\(tvShow.posterPath)"
        self.title = tvShow.name
        self.releaseDate = tvShow.firstAirDate
        self.votesAverage = String(format: "%.1f", tvShow.voteAverage)
        let genres = [Genre]()
        var aux = ""
        for i in 0..<tvShow.genreIds.count {
            let genre = genres.first { (genre) -> Bool in
                genre.id == tvShow.genreIds[i]
            }
            if genre != nil {
                aux = (i == tvShow.genreIds.count - 1) ? "\(genre!.name) |" : "\(genre!.name)"
            }
        }
        self.categories = aux
    }
}
