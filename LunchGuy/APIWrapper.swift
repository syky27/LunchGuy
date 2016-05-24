//
//  APIWrapper.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class APIWrapper {

	class var instance: APIWrapper {
		struct Singleton {
			static let instance: APIWrapper = APIWrapper()
		}
		return Singleton.instance
	}

	enum Router: URLRequestConvertible {

		static let baseURL = "http://obedar.fit.cvut.cz/obedar/api/v1"
		case Restaurants
		case Menu(restaurant: Restaurant)

		var method: Alamofire.Method {
			switch self {
			case .Restaurants:
				return .GET
			case .Menu:
				return .GET
			}
		}

		var path: String {
			switch self {
			case .Restaurants:
				return "/restaurants.json"
			case .Menu(let restaurant):
				return "/restaurants/\(restaurant.restaurantID)/menu.json"
			}
		}

		var URLRequest: NSMutableURLRequest {
			let url = NSURL(string: Router.baseURL)!
			let mutableRequest = NSMutableURLRequest(URL: url.URLByAppendingPathComponent(path))
			mutableRequest.HTTPMethod = method.rawValue


			switch self {
			case .Restaurants:
				return Alamofire.ParameterEncoding.JSON.encode(mutableRequest, parameters: nil).0
			case .Menu:
				return Alamofire.ParameterEncoding.JSON.encode(mutableRequest, parameters: nil).0
			}
		}
	}

	func getRestaurants(completion: (error: NSError?)->()) {
		Alamofire.request(Router.Restaurants)
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.responseJSON { response in
				switch response.result {
				case .Success:
					if let networkingData = response.data{
						let json = JSON(data:networkingData)
						for restaurantName in json.arrayObject! {
							let restaurant = Restaurant()
							restaurant.restaurantID = restaurantName as! String
							self.getMenuForRestaurant(restaurant, completion: { (error) in
								print(error)
							})
						}

					}
				case .Failure:
					completion(error: NSError(domain: "Networking", code: 1, userInfo: nil))

				}
		}
	}

	func getMenuForRestaurant(restaurant: Restaurant, completion: (error: NSError?)->()) {
		Alamofire.request(Router.Menu(restaurant: restaurant))
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.responseJSON { response in
				switch response.result {
				case .Success:
					if let networkingData = response.data{
						let json = JSON(data:networkingData)

						do {
							let realm = try Realm()
							print(Realm.Configuration.defaultConfiguration.fileURL!)
							realm.beginWrite()

							let restaurant = Restaurant()
							restaurant.restaurantID = json["data"]["attributes"]["title"].stringValue
							realm.add(restaurant, update: true)

							let menu = Menu()
							menu.menuID = json["data"]["attributes"]["title"].stringValue
							menu.cached = NSDate.dateFromISOString(json["data"]["attributes"]["cached"].stringValue)
							realm.add(menu, update: true)

							for content in json["data"]["attributes"]["content"].dictionaryValue {
								for obj in json["data"]["attributes"]["content"][content.0].arrayValue {
									let meal = Meal()
									meal.name = obj.first!.1.rawString()!
									meal.price = obj[1].rawValue as? Int ?? 0
									meal.type = content.0
									realm.add(meal)
									menu.meals.append(meal)
								}
							}

							try realm.commitWrite()
							completion(error: nil)
						} catch (let error as NSError) {
							completion(error: error)
						}
					}
				case .Failure:
					completion(error: NSError(domain: "Networking", code: 1, userInfo: nil))

				}
		}
	}

}















