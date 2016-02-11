//
//  RespositoryModel.swift
//  RxMoyaExample
//
//  Created by Lukasz Mroz on 11.02.2016.
//  Copyright © 2016 Droids on Roids. All rights reserved.
//

import Foundation
import Mapper

struct Repository: Mappable {
    
    let identifier: Int
    let language: String
    let url: String?
    let name: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try language = map.from("language")
        try name = map.from("name")
        url = map.optionalFrom("url")
    }
    
}