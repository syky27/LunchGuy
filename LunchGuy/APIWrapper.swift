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

    // MARK: Public API

    func restaurants(completion: @escaping (Result<[Restaurant]>) -> Void) {
        jsonRequest(router: .restaurants) { result in
            let restaurantsResult = result.map { json in
                return json.arrayValue.map { Restaurant(restaurantID: $0.stringValue) }
            }

            completion(restaurantsResult)
        }
    }

    func menu(for restaurant: Restaurant, completion: @escaping (Result<Menu>) -> Void) {
        jsonRequest(router: .menu(restaurant: restaurant)) { result in
            let menuResult = result.map { json -> Menu in
                let attributes = json["data"]["attributes"]

                let meals = attributes["content"].dictionaryValue.flatMap { mealType, json -> [Meal] in
                    return json.arrayValue.map { mealJSON in
                        let data = mealJSON.arrayValue
                        let price = data.count >= 2 ? data[1].int : nil

                        return Meal(type: mealType,
                             name: data.first?.stringValue ?? "", // Just to satisfy Swift type system, always succeeds
                             price: price,
                             restaurantID: restaurant.restaurantID)
                    }
                }

                return Menu(menuID: attributes["title"].stringValue,
                            cached: Date(),
                            meals: meals)
            }

            completion(menuResult)
        }
    }

    // MARK: Networking logic

    private func jsonRequest(router: Router, completion: @escaping (Result<JSON>) -> Void) {
        Alamofire.request(router)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                completion(response.result.map(JSON.init))
            }
    }
}
