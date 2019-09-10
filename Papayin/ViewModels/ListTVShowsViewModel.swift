//
//  ListTVShowsViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct ListTVShowsViewModel {
    let tvShow: TVShow
    let image: String
    let title: String
    let releaseDate: String
    let categories: String
    let votesAverage: String
    
    init(tvShow: TVShow) {
        self.tvShow = tvShow
        self.image = "\(Constants.Url.imageUrl)\(tvShow.posterPath)"
        self.title = tvShow.name
        self.releaseDate = tvShow.firstAirDate
        self.votesAverage = String(format: "%.1f", tvShow.voteAverage)
        guard let data = UserDefaults.standard.data(forKey: Constants.Keys.genres),
            let genres = try? JSONDecoder().decode([Genre].self, from: data) else {
            self.categories = ""
            return
        }
        var aux = ""
        for i in 0..<tvShow.genreIds.count {
            let genre = genres.first { (genre) -> Bool in
                genre.id == tvShow.genreIds[i]
            }
            if genre != nil {
                if i == 0 {
                    aux.append("\(genre!.name)")
                } else if i != tvShow.genreIds.count - 1 {
                    aux.append(" | \(genre!.name)")
                } else {
                    aux.append((tvShow.genreIds.count == 1) ? "\(genre!.name)." : " | \(genre!.name).")
                }
            }
        }
        self.categories = (aux.isEmpty) ? "-" : aux
    }
}
