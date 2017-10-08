//
//  MenuTableViewController.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftFetchedResultsController
import SafeRealmObject


class MenuTableViewController: UITableViewController {
	var fetchedResultsController: FetchedResultsController<Meal>?
	var restaurantID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier2")
		title = restaurantID

		let predicate = NSPredicate(format: "restaurantID == %@", restaurantID)
		let realm = try! Realm()
		let fetchRequest = FetchRequest<Meal>(realm: realm, predicate: predicate)
		let sortDescriptor = SortDescriptor(property: "type", ascending: false)
		fetchRequest.sortDescriptors = [sortDescriptor]

		self.fetchedResultsController = FetchedResultsController<Meal>(fetchRequest: fetchRequest, sectionNameKeyPath: "type", cacheName: "testCache")
		self.fetchedResultsController!.delegate = self
		self.fetchedResultsController!.performFetch()

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 44

		NotificationCenter.default
			.addObserver(self,
			             selector: #selector(MenuTableViewController.reloadTableView),
			             name: NSNotification.Name(rawValue: "updateFinished"),
			             object: nil)

    }

	@objc func reloadTableView() {
		tableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return (fetchedResultsController?.numberOfSections())!
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (fetchedResultsController?.numberOfRowsForSectionIndex(section))!
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier2")
		let meal = fetchedResultsController?.objectAtIndexPath(indexPath)
		cell.textLabel?.text = meal!.name
		cell.textLabel?.numberOfLines = 0
		cell.textLabel?.frame = CGRect(x: cell.textLabel!.frame.origin.x, y: cell.textLabel!.frame.origin.y, width: 50, height: cell.textLabel!.frame.size.height);
		cell.detailTextLabel?.text = "\(meal!.price) Kč"
        cell.detailTextLabel?.text = meal!.price < 1 ? "Cena není známa" : "\(meal!.price) Kč"

		return cell
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return fetchedResultsController?.sectionIndexTitles![section]
	}

}

extension MenuTableViewController: FetchedResultsControllerDelegate {
	func controllerWillChangeContent<T : Object>(_ controller: FetchedResultsController<T>) {
		self.tableView.beginUpdates()
	}

    func controller<T>(_ controller: FetchedResultsController<T>, didChangeObject anObject: SafeObject<T>, atIndexPath indexPath: IndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) where T : Object {

        let tableView = self.tableView

        switch type {
        case .insert:
            tableView?.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.fade)

        case .delete:
            tableView?.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.fade)

        case .update:
            tableView?.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.fade)

        case .move:
            tableView?.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.fade)
            tableView?.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.fade)
        }

    }



	func controllerDidChangeSection<T : Object>(_ controller: FetchedResultsController<T>, section: FetchResultsSectionInfo<T>, sectionIndex: UInt, changeType: NSFetchedResultsChangeType) {

		let tableView = self.tableView
		if changeType == NSFetchedResultsChangeType.insert {
			let indexSet = IndexSet(integer: Int(sectionIndex))
			tableView?.insertSections(indexSet, with: UITableViewRowAnimation.fade)
		}
		else if changeType == NSFetchedResultsChangeType.delete {
			let indexSet = IndexSet(integer: Int(sectionIndex))
			tableView?.deleteSections(indexSet, with: UITableViewRowAnimation.fade)
		}
	}

	func controllerDidChangeContent<T : Object>(_ controller: FetchedResultsController<T>) {
		self.tableView.endUpdates()
	}
}
