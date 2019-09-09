//
//  MovieCastViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct MovieCastViewModel {
    let image: String
    let name: String
    let character: String
    
    init(cast: Cast) {
        self.image = "\(Constants.Url.imageUrl)\(cast.profilePath)"
        self.name = cast.name
        self.character = cast.character
    }
}
