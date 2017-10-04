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


		static let baseURL = "http://obedar.fit.cvut.cz/api/v1"
		case restaurants
		case menu(restaurant: Restaurant)

		var method: HTTPMethod {
			switch self {
			case .restaurants:
				return .get
			case .menu:
				return .get
			}
		}

		var path: String {
			switch self {
			case .restaurants:
				return "/restaurants.json"
			case .menu(let restaurant):
				return "/restaurants/\(restaurant.restaurantID)/menu.json"
			}
		}

        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURL.asURL()
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            return urlRequest
        }
	}

	func getRestaurants(_ completion: @escaping (_ error: NSError?)->()) {
        do {
            let realm = try Realm()
            try realm.write({
                realm.deleteAll()
            })
        }catch (let e) {
            debugPrint(e)
        }
		Alamofire.request(Router.restaurants)
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.responseJSON { response in
				switch response.result {
				case .success:
					if let networkingData = response.data{
						let json = JSON(data:networkingData)
						for restaurantName in json.arrayObject! {
							let restaurant = Restaurant()
							restaurant.restaurantID = restaurantName as! String
							self.getMenuForRestaurant(restaurant, completion: { (error) in
								print(error)
								completion(error)
							})
						}

					}
				case .failure:
					completion(NSError(domain: "Networking", code: 1, userInfo: nil))

				}
		}
	}

	func getMenuForRestaurant(_ restaurant: Restaurant, completion: @escaping (_ error: NSError?)->()) {
		Alamofire.request(Router.menu(restaurant: restaurant))
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.responseJSON { response in
				switch response.result {
				case .success:
					if let networkingData = response.data{
						let json = JSON(data:networkingData)

						do {
							let realm = try Realm()
                            print(realm.configuration.fileURL?.absoluteString)
							realm.beginWrite()

							let restaurant = Restaurant()
							restaurant.restaurantID = json["data"]["attributes"]["title"].stringValue
							realm.add(restaurant, update: true)

                            // It is wanted to delete all menus and replace them with new one as new day comes
//                            let allMenus = realm.objects(Menu)
//                            realm.delete(allMenus)
                            
							let menu = Menu()
							menu.menuID = json["data"]["attributes"]["title"].stringValue
							menu.cached = Date.dateFromISOString(json["data"]["attributes"]["cached"].stringValue)
							realm.add(menu, update: true)
                            
                            
							for content in json["data"]["attributes"]["content"].dictionaryValue {
								for obj in json["data"]["attributes"]["content"][content.0].arrayValue {
									let meal = Meal()
                                    
									meal.name = obj.first!.1.rawString()!
									meal.price = obj[1].rawValue as? Int ?? 0
									meal.type = content.0
									meal.restaurantID = restaurant.restaurantID
									meal.mealID = meal.restaurantID + meal.name
									realm.add(meal, update: true)
									menu.meals.append(meal)
								}
							}

							try realm.commitWrite()
							completion( nil)
							NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateFinished"), object: nil)
						} catch (let error as NSError) {
							completion(error)
						}
					}
				case .failure:
					completion(NSError(domain: "Networking", code: 1, userInfo: nil))

				}
		}
	}
}















