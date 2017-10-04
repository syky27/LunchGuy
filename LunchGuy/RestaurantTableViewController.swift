//
//  RestaurantTableViewController.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit
import RealmSwift


class RestaurantTableViewController: UITableViewController {
	var restaurants: Results<Restaurant>!

    override func viewDidLoad() {
        super.viewDidLoad()
		title = "Restaurace"
		refreshControl = UIRefreshControl()
		refreshControl!.backgroundColor = UIColor.white
		refreshControl?.addTarget(self,
		                          action: #selector(RestaurantTableViewController.downloadNewData),
		                          for: UIControlEvents.valueChanged)

		self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")

		NotificationCenter.default
			.addObserver(self,
			             selector: #selector(RestaurantTableViewController.fetchNewData),
			             name: NSNotification.Name(rawValue: "updateFinished"),
			             object: nil)
		fetchNewData()
    }

	@objc func downloadNewData() {
		APIWrapper.instance.getRestaurants { (error) in
			self.refreshControl?.endRefreshing()
			if error != nil {
				print(error)
			} else {
				self.fetchNewData()
			}
		}

	}

	@objc func fetchNewData() {
		do {
			let realm = try Realm()
			restaurants = realm.objects(Restaurant.self)
			tableView.reloadData()
		} catch {
			print(error)
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let menuViewController = MenuTableViewController()
		menuViewController.restaurantID = restaurants[indexPath.row].restaurantID
		navigationController?.pushViewController(menuViewController, animated: true)
	}

}
