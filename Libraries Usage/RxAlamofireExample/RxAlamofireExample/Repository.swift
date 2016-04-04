//
//  Repository.swift
//  RxAlamofireExample
//
//  Created by Lukasz Mroz on 10.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: Mappable {
    var identifier: Int!
    var language: String!
    var url: String!
    var name: String!
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        language <- map["language"]
        url <- map["url"]
        name <- map["name"]
    }
}
