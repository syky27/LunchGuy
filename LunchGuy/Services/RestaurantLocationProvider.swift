//
//  RestaurantLocationProvider.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 26/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import CoreLocation

protocol RestaurantLocationProvider {
    func coordinates(for restaurant: Restaurant) -> CLLocationCoordinate2D?
}
