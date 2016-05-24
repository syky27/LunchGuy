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

class MenuTableViewController: UITableViewController {
	var fetchedResultsController: FetchedResultsController<Meal>?
	var restaurantID: String!

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "reuseIdentifier2")
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

		NSNotificationCenter.defaultCenter()
			.addObserver(self,
			             selector: #selector(MenuTableViewController.reloadTableView),
			             name: "updateFinished",
			             object: nil)

    }

	func reloadTableView() {
		tableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return (fetchedResultsController?.numberOfSections())!
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (fetchedResultsController?.numberOfRowsForSectionIndex(section))!
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "reuseIdentifier2")
		let meal = fetchedResultsController?.objectAtIndexPath(indexPath)
		cell.textLabel?.text = meal!.name
		cell.textLabel?.numberOfLines = 0
		cell.textLabel?.frame = CGRectMake(cell.textLabel!.frame.origin.x, cell.textLabel!.frame.origin.y, 50, cell.textLabel!.frame.size.height);
		cell.detailTextLabel?.text = "\(meal!.price) Kč"

		return cell
	}

	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return fetchedResultsController?.sectionIndexTitles![section]
	}

}

extension MenuTableViewController: FetchedResultsControllerDelegate {
	func controllerWillChangeContent<T : Object>(controller: FetchedResultsController<T>) {
		self.tableView.beginUpdates()
	}

	func controllerDidChangeObject<T : Object>(controller: FetchedResultsController<T>, anObject: SafeObject<T>, indexPath: NSIndexPath?, changeType: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
		let tableView = self.tableView

		switch changeType {
		case .Insert:
			tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)

		case .Delete:
			tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)

		case .Update:
			tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)

		case .Move:
			tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
			tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
		}
	}

	func controllerDidChangeSection<T : Object>(controller: FetchedResultsController<T>, section: FetchResultsSectionInfo<T>, sectionIndex: UInt, changeType: NSFetchedResultsChangeType) {

		let tableView = self.tableView
		if changeType == NSFetchedResultsChangeType.Insert {
			let indexSet = NSIndexSet(index: Int(sectionIndex))
			tableView.insertSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
		}
		else if changeType == NSFetchedResultsChangeType.Delete {
			let indexSet = NSIndexSet(index: Int(sectionIndex))
			tableView.deleteSections(indexSet, withRowAnimation: UITableViewRowAnimation.Fade)
		}
	}

	func controllerDidChangeContent<T : Object>(controller: FetchedResultsController<T>) {
		self.tableView.endUpdates()
	}
}
