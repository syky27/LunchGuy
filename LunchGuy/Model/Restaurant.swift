//
//  Restaurant.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 23/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import Foundation

class Restaurant: Decodable {
    let name: String
    var menu: Menu?

    init(name: String, menu: Menu? = nil) {
        self.name = name
        self.menu = menu
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let restaurantName = try container.decode(String.self)

        self.init(name: restaurantName)
    }
}
