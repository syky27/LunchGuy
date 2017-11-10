//
//  AppleMapsApp.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 28/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import Foundation

enum AppleMapsApp: ExternalApp {
    case search(place: String)

    var urlScheme: URL { return URL(string: "http://maps.apple.com")! }

    var displayName: String { return L10n.ExternalApp.appleMaps }

    var deepLink: URL {
        switch self {
        case let .search(place):
            return URL(string: "\(urlScheme.absoluteString)?q=\(urlEncodedParameter(place))")!
        }
    }
}
