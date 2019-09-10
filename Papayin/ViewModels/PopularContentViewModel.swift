//
//  PopularContentViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct PopularContentViewModel {
    let id: Int
    let image: String
    
    init(movie: Movie) {
        self.id = movie.id
        self.image = "\(Constants.Url.imageUrl)\(movie.posterPath)"
    }
    
    init(tvShow: TVShow) {
        self.id = tvShow.id
        self.image = "\(Constants.Url.imageUrl)\(tvShow.posterPath)"
    }
}
