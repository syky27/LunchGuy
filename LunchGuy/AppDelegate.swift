//
//  AppDelegate.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/05/16.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		Fabric.with([Crashlytics.self])
		APIWrapper.instance.getRestaurants { (error) in
			print(error?.localizedDescription)
		}
		window = UIWindow(frame: UIScreen.main.bounds)
		if let window = window {
			window.backgroundColor = UIColor.white
			window.rootViewController = UINavigationController(rootViewController: RestaurantTableViewController())
			window.makeKeyAndVisible()
		}
		return true
	}
}
