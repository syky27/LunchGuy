//
//  MenuTableViewController.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier2")
        title = restaurant.name

        tableView.tableFooterView = UIView()
        refreshControl = UIRefreshControl()
        refreshControl!.backgroundColor = UIColor.white
        refreshControl?.addTarget(self,
                                  action: #selector(loadMenu),
                                  for: UIControlEvents.valueChanged)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44

        // Load menus if it was not loaded previously
        if restaurant.menus.isEmpty {
            loadMenu()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return restaurant.menus.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.menus[section].meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier2")
        let meal = restaurant.menus[indexPath.section].meals[indexPath.row]

        cell.textLabel?.text = meal.name
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.frame = CGRect(x: cell.textLabel!.frame.origin.x, y: cell.textLabel!.frame.origin.y,
                                       width: 50, height: cell.textLabel!.frame.size.height)
        cell.detailTextLabel?.text = meal.price.flatMap { "\($0) Kč" } ?? "Cena není známa"

        return cell
    }

    // MARK: - Network logic

    @objc private func loadMenu() {
        refreshControl?.beginRefreshing()

        APIWrapper.instance.menus(for: restaurant) { [weak self] result in
            self?.refreshControl?.endRefreshing()

            switch result {
            case let .success(menus):
                self?.restaurant.menus = menus
                self?.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
}
