//
//  ExternalApp.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 28/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import Foundation

protocol ExternalApp {
    var urlScheme: URL { get }

    var deepLink: URL { get }

    var displayName: String { get }

    func urlEncodedParameter(_ parameter: String) -> String
}

extension ExternalApp {
    func urlEncodedParameter(_ parameter: String) -> String {
        return parameter.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
