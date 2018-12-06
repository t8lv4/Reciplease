//
//  Ingredients.swift
//  Reciplease
//
//  Created by Morgan on 06/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Structure ingredients
struct Ingredient {
    /**
     Catch a user input list of ingredients
     - Parameters:
        - ingredients: The user input

     - Returns:
        A string ready to be encoded as a url parameter (cf YummlyService)
     */
    func catchList(of ingredients: String) -> String {
        let ingredientsList = ingredients.replacingOccurrences(of: "\n", with: " ")
        return ingredientsList
    }
}
