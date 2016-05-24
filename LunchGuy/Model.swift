//
//  Model.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class Restaurant: Object {
	dynamic var restaurantID = ""

	override static func primaryKey() -> String? {
		return "restaurantID"
	}
}

class Menu: Object {
	dynamic var menuID = ""
	dynamic var cached = NSDate()
	var meals = List<Meal>()

	override static func primaryKey() -> String? {
		return "menuID"
	}
}

class Meal: Object {
	dynamic var mealID = ""
	dynamic var type = ""
	dynamic var name = ""
	dynamic var price = 0
	dynamic var restaurantID = ""

	override static func primaryKey() -> String? {
		return "mealID"
	}
}

