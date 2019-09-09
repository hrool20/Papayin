//
//  ProductionCompanyViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct ProductionCompanyViewModel {
    let image: String
    let name: String
    
    init(productionCompany: Company) {
        self.image = (productionCompany.logoPath.isEmpty) ? "" : "\(Constants.Url.imageUrl)\(productionCompany.logoPath)"
        self.name = productionCompany.name
    }
}
