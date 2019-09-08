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
    
    init(movie: Movie) {
        self.image = "\(Constants.Url.imageUrl)\(movie.posterPath)"
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.votesAverage = String(format: "%.1f", movie.voteAverage)
        let genres = [Genre]()
        var aux = ""
        for i in 0..<movie.genres.count {
            let genre = genres.first { (genre) -> Bool in
                genre.id == movie.genres[i]
            }
            if genre != nil {
                aux = (i == movie.genres.count - 1) ? "\(genre!.name) |" : "\(genre!.name)"
            }
        }
        self.categories = aux
    }
}
