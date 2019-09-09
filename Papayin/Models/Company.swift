//
//  Company.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class Company {
    var id: Int
    var name: String
    var logoPath: String
    var originCountry: String
    
    init() {
        self.id = 0
        self.name = ""
        self.logoPath = ""
        self.originCountry = ""
    }
    
    init(id: Int, name: String, logoPath: String, originCountry: String) {
        self.id = id
        self.name = name
        self.logoPath = logoPath
        self.originCountry = originCountry
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  name: jsonObject["name"].stringValue,
                  logoPath: jsonObject["logo_path"].stringValue,
                  originCountry: jsonObject["origin_country"].stringValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Company] {
        var models = [Company]()
        for jsonObject in jsonArray {
            models.append(Company.init(fromJSONObject: jsonObject))
        }
        
        return models
    }
}
