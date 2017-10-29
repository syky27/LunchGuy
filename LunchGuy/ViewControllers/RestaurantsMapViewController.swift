//
//  RestaurantsMapViewController.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 27/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import UIKit
import MapKit

class RestaurantsMapViewController: UIViewController, MKMapViewDelegate {

    private static let defaultMapRegion = MKCoordinateRegion(
        center: .init(latitude: 50.104591823066585, longitude: 14.392029968806042),
        span: .init(latitudeDelta: 0.014363891112303406, longitudeDelta: 0.013927242281056351)
    )

    private let mapView = MKMapView()
    private let locationProvider = RestaurantStaticLocationProvider()
    private let restaurantsDataSource: RestaurantsDataSource

    private var selectedRestaurant: Restaurant?

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

        mapView.delegate = self
        mapView.setRegion(RestaurantsMapViewController.defaultMapRegion, animated: false)

        locateRestaurants()
    }

    // MARK: MKMapViewDelegate

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? RestaurantAnnotation else { return }

        selectedRestaurant = annotation.restaurant
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        selectedRestaurant = nil
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard
            !(annotation is MKUserLocation),
            #available(iOS 11.0, *)
        else {
            // Fallback to system default
            return nil
        }

        let markerView
            = (mapView.dequeueReusableAnnotationView(withIdentifier: "markerView") as? MKMarkerAnnotationView)
            ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "markerView")
        let detailButton = UIButton(type: .detailDisclosure)

        detailButton.addTarget(self, action: #selector(openRestaurantMenuHandler), for: .touchUpInside)

        markerView.canShowCallout = true
        markerView.rightCalloutAccessoryView = detailButton

        return markerView
    }

    // MARK: UI callbacks

    @objc func openRestaurantMenuHandler() {
        guard let restaurant = selectedRestaurant else { return }

        let controller = MenuTableViewController()
        controller.restaurant = restaurant

        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: Internal logic

    private func locateRestaurants() {
        // Get coordinates of restaurant and create annotation if it's possible
        let annotations = restaurantsDataSource.restaurants.flatMap { restaurant -> RestaurantAnnotation? in
            guard let coordinate = locationProvider.coordinates(for: restaurant) else { return nil }

            return RestaurantAnnotation(restaurant: restaurant, coordinate: coordinate)
        }

        render(annotations: annotations)
    }

    private func render(annotations: [MKAnnotation]) {
        // Remove all map annotations currently rendered
        mapView.removeAnnotations(mapView.annotations)

        // Render all annotations on clean canvas
        mapView.addAnnotations(annotations)
    }
}

extension RestaurantsMapViewController: RestaurantsObserver {
    func restaurantsChanged() {
        locateRestaurants()
    }
}
