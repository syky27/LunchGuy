//
//  RestaurantTableViewController.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurants: [Restaurant] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Restaurace"
        tableView.tableFooterView = UIView()
		refreshControl = UIRefreshControl()
		refreshControl!.backgroundColor = UIColor.white
		refreshControl?.addTarget(self,
		                          action: #selector(loadRestaurants),
		                          for: UIControlEvents.valueChanged)

		self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")

        loadRestaurants()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = restaurants[indexPath.row].restaurantID

        return cell
    }

    // MARK: - Table view delegate

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let menuViewController = MenuTableViewController()

        menuViewController.restaurant = restaurants[indexPath.row]
		navigationController?.pushViewController(menuViewController, animated: true)
	}

    // MARK: - Network logic

    @objc func loadRestaurants() {
        refreshControl?.beginRefreshing()

        APIWrapper.instance.restaurants { [weak self] result in
            self?.refreshControl?.endRefreshing()

            switch result {
            case let .success(restaurants):
                self?.restaurants = restaurants
                self?.tableView.reloadData()
            case let .failure(error):
                APIError(error).show()
            }
        }
    }
}
