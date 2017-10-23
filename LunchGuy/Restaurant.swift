//
//  Restaurant.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 23/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import Foundation

class Restaurant {
    let restaurantID: String
    let name: String
    var menus: [Menu]

    init(restaurantID: String, name: String, menus: [Menu]) {
        self.restaurantID = restaurantID
        self.name = name
        self.menus = menus
    }
}
