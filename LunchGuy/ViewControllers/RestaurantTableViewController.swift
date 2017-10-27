//
//  RestaurantTableViewController.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    private let restaurantsDataSource: RestaurantsDataSource

    init(restaurantsDataSource: RestaurantsDataSource) {
        self.restaurantsDataSource = restaurantsDataSource

        super.init(style: .plain)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
		refreshControl = UIRefreshControl()
		refreshControl!.backgroundColor = UIColor.white
		refreshControl?.addTarget(self,
		                          action: #selector(loadRestaurants),
		                          for: UIControlEvents.valueChanged)

		self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")

        restaurantsDataSource.addObserver(self)

        loadRestaurants()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsDataSource.restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = restaurantsDataSource.restaurants[indexPath.row].name

        return cell
    }

    // MARK: - Table view delegate

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let menuViewController = MenuTableViewController()

        menuViewController.restaurant = restaurantsDataSource.restaurants[indexPath.row]
		navigationController?.pushViewController(menuViewController, animated: true)
	}

    // MARK: - Network logic

    @objc func loadRestaurants() {
        refreshControl?.beginRefreshing()

        APIWrapper.instance.restaurants { [weak self] result in
            self?.refreshControl?.endRefreshing()

            switch result {
            case let .success(restaurants):
                self?.restaurantsDataSource.restaurants = restaurants
            case let .failure(error):
                APIError(error).show()
            }
        }
    }
}

extension RestaurantTableViewController: RestaurantsObserver {
    func restaurantsChanged() {
        tableView.reloadData()
    }
}
