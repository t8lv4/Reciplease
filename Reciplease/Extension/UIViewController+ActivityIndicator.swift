//
//  UIViewController+ActivityIndicator.swift
//  Reciplease
//
//  Created by Morgan on 13/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Toggle an activity indicator
    func toggleActivityIndicator(_ indicator: UIActivityIndicatorView, shown: Bool) {
        indicator.isHidden = !shown
    }
}
