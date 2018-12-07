//
//  Recipes.swift
//  
//
//  Created by Morgan on 05/12/2018.
//

import Foundation

/// Mirror Yummly's JSON structure
struct Recipes: Decodable {
    let matches: [Recipe]
    let totalMatchCount: Int

    struct Recipe: Decodable {
        let recipeName: String
        let id: String
        let rating: Int?
        let totalTimeInSeconds: Int?
        let smallImageUrls: [String]?
    }
}

