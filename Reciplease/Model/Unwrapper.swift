//
//  Unwrapper.swift
//  Reciplease
//
//  Created by Morgan on 23/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// List optionals
enum RecipleaseOptionals {
    case rating, time
}

/// Unwrap optionals
struct Unwrapper {
    /**
     Unwrap optionals and prepare them for UI display

     - parameter optional: The optional to unwrap
     - parameter recipe: Item returned by the Yummly API

     - Returns: A string, either the optional's value or n/a
     */
    static func unwrap(_ optional: RecipleaseOptionals, for recipe: Recipes.Recipe) -> String {
        switch optional {
        case .rating:
            if let rating = recipe.rating {
                return String(rating) + " ⭐️"
            } else {
                return "n/a"
            }
        case .time:
            if let time = recipe.totalTimeInSeconds {
                return String(time / 60) + "'"
            } else {
                return "n/a"
            }
        }
    }
}
