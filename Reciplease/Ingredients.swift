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
     Format a user input list of ingredients
     - Parameters:
        - ingredients: The user input

     - Returns:
        A string ready to be encoded as a url parameter (cf YummlyService)
     */
    func formatList(of ingredients: String, with occurences: (String, String)) -> String {
        let ingredientsList = ingredients.replacingOccurrences(of: occurences.0, with: occurences.1)
        return ingredientsList
    }
}
