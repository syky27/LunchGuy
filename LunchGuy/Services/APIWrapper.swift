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
                return "/restaurants/\(restaurant.name)/menu.json"
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
        jsonRequest(ofType: [Restaurant].self, router: .restaurants, completion: completion)
    }

    func menu(for restaurant: Restaurant, completion: @escaping (Result<Menu>) -> Void) {
        jsonRequest(ofType: Menu.self, router: .menu(restaurant: restaurant), completion: completion)
    }

    // MARK: Networking logic

    private func jsonRequest<T: Decodable>(ofType type: T.Type, router: Router, completion: @escaping (Result<T>) -> Void) {
        Alamofire.request(router)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                let objectResponse = response.result.flatMap { data -> T in
                    let decoder = JSONDecoder()

                    return try decoder.decode(T.self, from: data)
                }

                completion(objectResponse)
            }
    }
}
