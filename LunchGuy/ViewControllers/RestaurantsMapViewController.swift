//
//  RestaurantsMapViewController.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 27/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import UIKit
import MapKit

class RestaurantsMapViewController: UIViewController {

    struct LocatedRestaurant {
        let restaurant: Restaurant
        let coordinates: CLLocationCoordinate2D
    }

    private let mapView = MKMapView()
    private let locationProvider = RestaurantStaticLocationProvider()
    private let restaurantsDataSource: RestaurantsDataSource
    private var locatedRestaurants = [LocatedRestaurant]()

    init(restaurantsDataSource: RestaurantsDataSource) {
        self.restaurantsDataSource = restaurantsDataSource

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view.addSubview(mapView)

        let constraints = [
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        mapView.translatesAutoresizingMaskIntoConstraints = false
        constraints.forEach { $0.isActive = true }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locateRestaurants()
    }

    private func locateRestaurants() {
        locatedRestaurants = restaurantsDataSource.restaurants.flatMap { restaurant in
            guard let coordinates = locationProvider.coordinates(for: restaurant) else { return nil }

            return LocatedRestaurant(restaurant: restaurant, coordinates: coordinates)
        }

        renderAnnotations()
    }

    private func renderAnnotations() {
        // Remove all map annotations currently rendered
        mapView.removeAnnotations(mapView.annotations)

        // Render all annotations on clean canvas
        locatedRestaurants.forEach { locatedRestaurant in
            let annotation = MKPointAnnotation()

            annotation.coordinate = locatedRestaurant.coordinates
            mapView.addAnnotation(annotation)
        }
    }
}

extension RestaurantsMapViewController: RestaurantsObserver {
    func restaurantsChanged() {
        locateRestaurants()
    }
}
