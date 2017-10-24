//
//  Meal.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 23/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import Foundation

struct Meal: Codable {
    let name: String
    let price: Int?

    init(name: String, price: Int?) {
        self.name = name
        self.price = price
    }

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let name = try container.decode(String.self)
        let price = try? container.decode(Int.self)

        self.init(name: name, price: price)
    }
}
