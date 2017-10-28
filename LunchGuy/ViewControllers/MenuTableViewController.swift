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

    private var actionButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action,
                                           target: self, action: #selector(actionButtonHanlder))

        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier2")
        navigationItem.title = restaurant.name
        navigationItem.rightBarButtonItem = actionButton

        tableView.tableFooterView = UIView()
        refreshControl = UIRefreshControl()
        refreshControl!.backgroundColor = UIColor.white
        refreshControl?.addTarget(self,
                                  action: #selector(loadMenu),
                                  for: UIControlEvents.valueChanged)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44

        // Load menu if it was not loaded previously
        if restaurant.menu == nil {
            loadMenu()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return restaurant.menu?.mealCategories.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.menu?.mealCategories[section].meals.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier2")
        let meal = restaurant.menu?.mealCategories[indexPath.section].meals[indexPath.row]

        cell.textLabel?.text = meal?.name
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.frame = CGRect(x: cell.textLabel!.frame.origin.x, y: cell.textLabel!.frame.origin.y,
                                       width: 50, height: cell.textLabel!.frame.size.height)
        cell.detailTextLabel?.text = meal?.price.flatMap { "\($0) Kč" } ?? "Cena není známa"

        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return restaurant.menu?.mealCategories[section].category
    }

    // MARK: UI callbacks

    @objc
    func actionButtonHanlder() {
        let controller = UIAlertController(title: "Choose an app where you want to open selected restaurant.", message: nil, preferredStyle: .actionSheet)

        let urlEscapedRestaurant = restaurant.name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let actions = [
            UIAlertAction(title: "Apple Maps", style: .default, handler: { _ in
                let url = URL(string: "http://maps.apple.com/?q=\(urlEscapedRestaurant)")!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }),
            UIAlertAction(title: "Google Maps", style: .default, handler: { _ in
                let url = URL(string: "comgooglemaps://?q=\(urlEscapedRestaurant)")!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }),
            UIAlertAction(title: "Yelp", style: .default, handler: { _ in
                let url = URL(string: "yelp4:///search?terms=\(urlEscapedRestaurant)")!

                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.openURL(url)
                }
            }),
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ]

        actions.forEach { controller.addAction($0) }

        present(controller, animated: true, completion: nil)
    }

    // MARK: - Network logic

    @objc private func loadMenu() {
        refreshControl?.beginRefreshing()

        APIWrapper.instance.menu(for: restaurant) { [weak self] result in
            self?.refreshControl?.endRefreshing()

            switch result {
            case let .success(menu):
                self?.restaurant.menu = menu
                self?.tableView.reloadData()
            case let .failure(error):
                APIError(error).show()
            }
        }
    }
}
