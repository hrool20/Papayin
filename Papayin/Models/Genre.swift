//
//  Genre.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/6/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class Genre {
    var id: Int
    var name: String
    
    init() {
        self.id = 0
        self.name = ""
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  name: jsonObject["name"].stringValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Genre] {
        var models = [Genre]()
        for jsonObject in jsonArray {
            models.append(Genre.init(fromJSONObject: jsonObject))
        }
        
        return models
    }
}
