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
	@objc dynamic var restaurantID = ""

	override static func primaryKey() -> String? {
		return "restaurantID"
	}
}

class Menu: Object {
	@objc dynamic var menuID = ""
	@objc dynamic var cached = Date()
	var meals = List<Meal>()

	override static func primaryKey() -> String? {
		return "menuID"
	}
}

class Meal: Object {
	@objc dynamic var mealID = ""
	@objc dynamic var type = ""
	@objc dynamic var name = ""
	@objc dynamic var price = 0
	@objc dynamic var restaurantID = ""

	override static func primaryKey() -> String? {
		return "mealID"
	}
}
