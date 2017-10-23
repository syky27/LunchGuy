//
//  Model.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import Foundation

struct Restaurant {
    let restaurantID: String
}

struct Menu {
    let menuID: String
    let cached: Date
    let meals: [Meal]
}

struct Meal {
    let type: String
    let name: String
    let price: Int?
    let restaurantID: String

    var mealID: String {
        return "\(restaurantID)_\(name)"
    }
}
