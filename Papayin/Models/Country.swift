//
//  Country.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class Country {
    var iso3166: String
    var name: String
    
    init() {
        self.iso3166 = ""
        self.name = ""
    }
    
    init(iso3166: String, name: String) {
        self.iso3166 = iso3166
        self.name = name
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        self.init(iso3166: jsonObject["iso_3166_1"].stringValue,
                  name: jsonObject["name"].stringValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Country] {
        var models = [Country]()
        for jsonObject in jsonArray {
            models.append(Country.init(fromJSONObject: jsonObject))
        }
        
        return models
    }
}
