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
    case rating, time, servings
}

/// Unwrap optionals
struct Unwrapper {
    /**
     Unwrap optionals to prepare them for UI display

     - parameter optional: The optional to unwrap
     - parameter recipe: Item returned by the Yummly API

     - Returns: A string to display, either the optional's value or n/a
     */
    static func unwrap(_ optional: RecipleaseOptionals, for recipe: Any) -> String {
        switch optional {
        case .rating:
            if let rating = (recipe as! Recipes.Recipe).rating {
                return String(rating) + " ⭐️"
            } else {
                return "n/a"
            }
        case .time:
            if let time = (recipe as! Recipes.Recipe).totalTimeInSeconds {
                return String(time / 60) + "'"
            } else {
                return "n/a"
            }
        case .servings:
            if let servings = (recipe as! DetailedRecipe).numberOfServings {
                return "Servings: " + String(servings)
            } else {
                return "n/a"
            }
        }
    }
}
