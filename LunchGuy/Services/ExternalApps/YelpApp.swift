//
//  YelpApp.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 28/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import Foundation

enum YelpApp: ExternalApp {
    case search(place: String)

    var urlScheme: URL { return URL(string: "yelp4://")! }

    var displayName: String { return "Yelp" }

    var deepLink: URL {
        switch self {
        case let .search(place):
            return URL(string: "\(urlScheme.absoluteString)/search?terms=\(urlEncodedParameter(place))")!
        }
    }
}
