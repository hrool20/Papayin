//
//  ResponseHelper.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/6/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ResponseHelper {
    static func POST(url: String, headers: [String: String]? = nil, parameters: [String: Any], successCompletion: @escaping (JSON) -> Void, failureCompletion: @escaping (Error) -> Void) -> Void {
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers)
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print("POST error: \(error.localizedDescription)")
                    failureCompletion(error)
                case .success(let value):
                    let jsonObject = JSON(value)
                    print("Response: \(jsonObject)")
                    successCompletion(jsonObject)
                }
        }
    }
    
    static func GET(url: String, headers: [String: String]? = nil, parameters: [String: Any], successCompletion: @escaping (JSON) -> Void, failureCompletion: @escaping (Error) -> Void) -> Void {
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers)
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print("GET error: \(error.localizedDescription)")
                    failureCompletion(error)
                case .success(let value):
                    let jsonObject = JSON(value)
                    print("Response: \(jsonObject)")
                    successCompletion(jsonObject)
                }
        }
    }
}
