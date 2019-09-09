//
//  MovieCompanyProductionViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct MovieCompanyProductionViewModel {
    let image: String
    let name: String
    
    init(companyProduction: Company) {
        self.image = (companyProduction.logoPath.isEmpty) ? "" : "\(Constants.Url.imageUrl)\(companyProduction.logoPath)"
        self.name = companyProduction.name
    }
}
