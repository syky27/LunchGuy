//
//  RestaurantsViewController.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 27/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import UIKit

enum LayoutStyle: Int {
    case list
    case map

    var description: String {
        switch self {
        case .list: return "List"
        case .map: return "Map"
        }
    }
}

class RestaurantsViewController: UIViewController {

    private var changeLayoutButton: UIBarButtonItem!
    private let restaurantsDataSource = RestaurantsDataSource()
    private let restaurantControllers: [UIViewController]

    private var currentLayout = LayoutStyle.list {
        didSet {
            switch currentLayout {
            case .list: changeLayoutButton.title = LayoutStyle.map.description
            case .map: changeLayoutButton.title = LayoutStyle.list.description
            }
        }
    }

    init() {
        self.restaurantControllers = [
            RestaurantTableViewController(restaurantsDataSource: restaurantsDataSource),
            RestaurantsMapViewController(restaurantsDataSource: restaurantsDataSource)
        ]

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let controller = restaurantControllers.first else { return }

        navigationItem.title = "Restaurace"
        changeLayoutButton = UIBarButtonItem(title: LayoutStyle.map.description, style: .plain,
                                             target: self, action: #selector(changeLayoutHandler))
        changeLayoutButton.isEnabled = false
        navigationItem.rightBarButtonItem = changeLayoutButton

        restaurantsDataSource.addObserver(self)
        add(controller: controller)
    }

    @objc
    func changeLayoutHandler() {
        let oldLayout = currentLayout
        let newLayout: LayoutStyle

        switch currentLayout {
        case .map: newLayout = .list
        case .list: newLayout = .map
        }

        currentLayout = newLayout
        changeLayout(from: restaurantControllers[oldLayout.rawValue],
                     to: restaurantControllers[newLayout.rawValue])
    }

    private func add(controller: UIViewController) {
        addChildViewController(controller)

        controller.view.frame = view.frame
        view.addSubview(controller.view)

        controller.didMove(toParentViewController: self)
    }

    private func changeLayout(from oldController: UIViewController,
                              to newController: UIViewController) {

        oldController.willMove(toParentViewController: nil)
        addChildViewController(newController)
        view.insertSubview(newController.view, belowSubview: oldController.view)
        changeLayoutButton.isEnabled = false

        let completion: (Bool) -> Void = { [weak self] _ in
            oldController.view.removeFromSuperview()
            oldController.removeFromParentViewController()

            newController.didMove(toParentViewController: self)
            self?.changeLayoutButton.isEnabled = true
        }

        UIView.transition(from: oldController.view, to: newController.view, duration: 1.0,
                          options: .transitionFlipFromLeft, completion: completion)
    }
}

extension RestaurantsViewController: RestaurantsObserver {
    func restaurantsChanged() {
        changeLayoutButton.isEnabled = !restaurantsDataSource.restaurants.isEmpty
    }
}
