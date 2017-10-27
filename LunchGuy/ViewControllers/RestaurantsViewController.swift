//
//  RestaurantsViewController.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 27/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {

    private let restaurantsListController = RestaurantTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Restaurace"

        add(controller: restaurantsListController)
    }

    private func add(controller: UIViewController) {
        addChildViewController(controller)

        controller.view.frame = view.frame
        view.addSubview(controller.view)

        controller.didMove(toParentViewController: self)
    }
}
