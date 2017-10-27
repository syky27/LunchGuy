//
//  RestaurantsDataSource.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 27/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import Foundation

protocol RestaurantsObserver: class {
    func restaurantsChanged()
}

class RestaurantsDataSource {
    var restaurants: [Restaurant] {
        didSet {
            notifyObservers()
        }
    }

    private var observers: [RestaurantsObserver]

    init() {
        self.restaurants = []
        self.observers = []
    }

    func addObserver(_ observer: RestaurantsObserver) {
        observers.append(observer)
    }

    func removeObserver(_ observer: RestaurantsObserver) {
        observers = observers.filter { $0 !== observer }
    }

    private func notifyObservers() {
        DispatchQueue.main.async { [weak self] in
            self?.observers.forEach { $0.restaurantsChanged() }
        }
    }
}
