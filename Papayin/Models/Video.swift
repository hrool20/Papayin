//
//  Video.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import SwiftyJSON

class Video {
    var id: String
    var name: String
    var key: String
    var type: String
    var site: String
    var size: Int
    var iso369: String
    var iso3166: String
    
    init() {
        self.id = ""
        self.name = ""
        self.key = ""
        self.type = ""
        self.site = ""
        self.size = 0
        self.iso369 = ""
        self.iso3166 = ""
    }
    
    init(id: String, name: String, key: String, type: String, site: String, size: Int, iso369: String, iso3166: String) {
        self.id = id
        self.name = name
        self.key = key
        self.type = type
        self.site = site
        self.size = size
        self.iso369 = iso369
        self.iso3166 = iso3166
    }
    
    convenience init(fromJSONObject jsonObject: JSON) {
        self.init(id: jsonObject["id"].stringValue,
                  name: jsonObject["name"].stringValue,
                  key: jsonObject["key"].stringValue,
                  type: jsonObject["type"].stringValue,
                  site: jsonObject["site"].stringValue,
                  size: jsonObject["size"].intValue,
                  iso369: jsonObject["iso_369_1"].stringValue,
                  iso3166: jsonObject["iso_3166_1"].stringValue)
    }
    
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Video] {
        var models = [Video]()
        for jsonObject in jsonArray {
            models.append(Video.init(fromJSONObject: jsonObject))
        }
        
        return models
    }
}
