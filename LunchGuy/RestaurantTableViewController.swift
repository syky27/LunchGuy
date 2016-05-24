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
		self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier")

		NSNotificationCenter.defaultCenter()
			.addObserver(self,
			             selector: #selector(RestaurantTableViewController.fetchNewData),
			             name: "updateFinished",
			             object: nil)
		fetchNewData()
    }

	func fetchNewData() {
		do {
			let realm = try Realm()
			restaurants = realm.objects(Restaurant)
			tableView.reloadData()
		} catch {
			print(error)
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
		cell.textLabel?.text = restaurants[indexPath.row].restaurantID
        return cell
    }

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let menuViewController = MenuTableViewController()
		menuViewController.restaurantID = restaurants[indexPath.row].restaurantID
		navigationController?.pushViewController(menuViewController, animated: true)
	}

}
