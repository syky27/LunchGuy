//
//  APIError.swift
//  LunchGuy
//
//  Created by Tomas Sykora, jr. on 24/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import UIKit
import Alamofire

struct APIError: Error {
    let title: String
    let message: String

    init(json: [String: Any]) {
        if let error = json["error"] as? [String: Any] {
            title = error["code"] as? String ?? L10n.Error.title
            message = error["message"] as? String ?? L10n.Error.unknown
        } else {
            title = L10n.Error.title
            message = L10n.Error.invalidResponse
        }
    }

    init(title: String, message: String) {
        self.title = title
        self.message = message
    }

    init(_ error: Error) {
        title = L10n.Error.title
        message = error.localizedDescription
    }

    func show() {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.General.ok, style: .default))
        alert.show()
    }

}

extension UIAlertController {
    func show() {
        DispatchQueue.main.async {
            let win = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIViewController()
            vc.view.backgroundColor = .clear
            win.rootViewController = vc
            win.windowLevel = UIWindowLevelAlert + 1
            win.makeKeyAndVisible()
            vc.present(self, animated: true, completion: nil)
        }
    }
}
