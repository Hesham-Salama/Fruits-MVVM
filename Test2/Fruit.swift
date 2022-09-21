//
//  Fruit.swift
//  Test2
//
//  Created by Hesham on 09/09/2022.
//

import Foundation

struct Fruit: Codable {
    let name: String
    let imageLink: String
    let price: Int
    let weight: Double?
    
    enum CodingKeys: String, CodingKey {
        case imageLink = "image"
        case name, price, weight
    }
}
