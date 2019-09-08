//
//  ListMoviesViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/6/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct ListMoviesViewModel {
    let image: String
    let title: String
    let releaseDate: String
    let votesAverage: String
    
    init(movie: Movie) {
        self.image = "\(Constants.Url.imageUrl)\(movie.posterPath)"
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.votesAverage = String(format: "%.1f", movie.voteAverage)
    }
}
