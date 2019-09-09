//
//  MovieDetailViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct MovieDetailViewModel {
    let movie: Movie
    let productionCompanies: [MovieCompanyProductionViewModel]
    let image: String
    let name: String
    let votesAverage: String
    let overview: String
    let releaseDate: String
    let genres: String
    let runtime: String
    let revenue: String
    let budget: String
    let productionCountries: String
    
    init(movie: Movie) {
        self.movie = movie
        self.image = "\(Constants.Url.imageUrl)/\(movie.posterPath)"
        self.name = movie.title
        self.votesAverage = "\(String(format: "%.1f", movie.voteAverage))"
        self.overview = movie.overview
        self.productionCompanies = movie.productionCompanies.map({ (companyProduction) -> MovieCompanyProductionViewModel in
            return MovieCompanyProductionViewModel(companyProduction: companyProduction)
        })
        self.releaseDate = movie.releaseDate
        var genreAux = ""
        for i in 0..<movie.genres.count {
            let genre = movie.genres[i]
            genreAux.append((i != movie.genres.count - 1) ? "\(genre.name), " : "\(genre.name)")
        }
        self.genres = genreAux
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "hh'h' mm'm'"
        self.runtime = (movie.runtime == 0) ? "-" : "\(dateFormatter.string(from: Date(timeIntervalSince1970: movie.runtime * 60)))"
        self.revenue = (movie.revenue == 0) ? "-" : "\(movie.revenue)"
        self.budget = (movie.budget == 0) ? "-" : "$ \(movie.budget)"
        var productionCountryAux = ""
        for i in 0..<movie.productionCountries.count {
            let productionCountry = movie.productionCountries[i]
            productionCountryAux.append((i != movie.productionCountries.count - 1) ? "\(productionCountry.name), " : "\(productionCountry.name)")
        }
        self.productionCountries = productionCountryAux
    }
}
