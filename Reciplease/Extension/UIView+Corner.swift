//
//  UIView+Corner.swift
//  Reciplease
//
//  Created by Morgan on 14/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
