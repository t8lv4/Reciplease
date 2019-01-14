//
//  UIViewController+AlertVC.swift
//  Reciplease
//
//  Created by Morgan on 13/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    /**
     Define a UIAlertController called by the ViewController
     - A message is displayed according to the input
     - The user dismiss the alert by clicking a "OK" button

     - Parameters:
     - title: The alert's title
     - message: The error message to be displayed
     */
    func presentVCAlert(title: AlertTitle, message: AlertMessage) {
        let alertVC = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
