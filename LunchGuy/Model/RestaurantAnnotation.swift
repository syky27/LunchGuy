//
//  RestaurantAnnotation.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 28/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import MapKit

class RestaurantAnnotation: NSObject, MKAnnotation {
    let restaurant: Restaurant
    let coordinate: CLLocationCoordinate2D

    var title: String? {
        return restaurant.name
    }

    init(restaurant: Restaurant, coordinate: CLLocationCoordinate2D) {
        self.restaurant = restaurant
        self.coordinate = coordinate

        super.init()
    }
}
