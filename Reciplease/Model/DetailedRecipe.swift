//
//  DetailedRecipe.swift
//  Reciplease
//
//  Created by Morgan on 27/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Mirror the Yummly JSON structure for a detailed recipe
struct DetailedRecipe: Decodable {
    let ingredientLines: [String]
    let numberOfServings: Int?
    let source: Source
    let images: [Images]

    struct Source: Decodable {
        let sourceRecipeUrl: String
    }

    struct Images: Decodable {
        let hostedLargeUrl: String?
    }
}
