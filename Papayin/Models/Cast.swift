//
//  Cast.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class Cast {
    var id: Int
    var castId: Int
    var creditId: String
    var name: String
    var profilePath: String
    var gender: Int
    var character: String
    var order: Int
    
    init() {
        self.id = 0
        self.castId = 0
        self.creditId = ""
        self.name = ""
        self.profilePath = ""
        self.gender = 0
        self.character = ""
        self.order = 0
    }
    
    init(id: Int, castId: Int, creditId: String, name: String, profilePath: String, gender: Int, character: String, order: Int) {
        self.id = id
        self.castId = castId
        self.creditId = creditId
        self.name = name
        self.profilePath = profilePath
        self.gender = gender
        self.character = character
        self.order = order
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  castId: jsonObject["cast_id"].intValue,
                  creditId: jsonObject["credit_id"].stringValue,
                  name: jsonObject["name"].stringValue,
                  profilePath: jsonObject["profile_path"].stringValue,
                  gender: jsonObject["gender"].intValue,
                  character: jsonObject["character"].stringValue,
                  order: jsonObject["order"].intValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Cast] {
        var models = [Cast]()
        for jsonObject in jsonArray {
            models.append(Cast.init(fromJSONObject: jsonObject))
        }
        
        return models
    }
}
