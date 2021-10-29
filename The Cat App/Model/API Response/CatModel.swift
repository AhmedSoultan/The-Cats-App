//
//  CatsModel.swift
//  The Cat App
//
//  Created by ahmed sultan on 26/10/2021.
//

import Foundation

struct CatModel: Decodable {
    let breeds : [Breeds]?
    let url : String?
}
