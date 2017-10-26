//
//  RestaurantStaticLocationProvider.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 26/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import CoreLocation

struct RestaurantStaticLocationProvider: RestaurantLocationProvider {

    private static let locations: [String: CLLocationCoordinate2D] = [
        "U Pětníka": CLLocationCoordinate2D(latitude: 50.104419, longitude: 14.396187),
        "Na Urale": CLLocationCoordinate2D(latitude: 50.102663, longitude: 14.402137),
        "Na Slamníku": CLLocationCoordinate2D(latitude: 50.103669, longitude: 14.408335),
        "U Topolů": CLLocationCoordinate2D(latitude: 50.106789, longitude: 14.395005),
        "U Profesora": CLLocationCoordinate2D(latitude: 50.10485, longitude: 14.39454),
        "Cesta časem": CLLocationCoordinate2D(latitude: 50.106447, longitude: 14.386742),
        "Bistro Santinka": CLLocationCoordinate2D(latitude: 50.106719, longitude: 14.388259),
        "Pod Juliskou": CLLocationCoordinate2D(latitude: 50.110736, longitude: 14.393782),
        "Pod Loubím": CLLocationCoordinate2D(latitude: 50.10035, longitude: 14.387883),
        "Kulaťák": CLLocationCoordinate2D(latitude: 50.100469, longitude: 14.397122),
        "Budvarka": CLLocationCoordinate2D(latitude: 50.09824, longitude: 14.396188),
        "Studentský dům": CLLocationCoordinate2D(latitude: 50.105539, longitude: 14.388883),
        "Pizzerie la fontanella": CLLocationCoordinate2D(latitude: 50.105701, longitude: 14.389107),
        "Masarykova kolej": CLLocationCoordinate2D(latitude: 50.101042, longitude: 14.3869)
    ]

    func coordinates(for restaurant: Restaurant) -> CLLocationCoordinate2D? {
        return RestaurantStaticLocationProvider.locations[restaurant.name]
    }
}
