//
//  APIWrapper.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//


import Foundation
import Alamofire


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
				return "/restaurants/"
			case .Menu(let restaurant):
				return "/restaurants/\(restaurant.restaurantID)U Pětníka/menu.json"
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
//						let json = JSON(data:networkingData)


					}
				case .Failure:
					completion(error: NSError(domain: "Networking", code: 1, userInfo: nil))

				}
		}
	}

}















