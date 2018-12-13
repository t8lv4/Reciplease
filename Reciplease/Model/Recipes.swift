//
//  Recipes.swift
//  
//
//  Created by Morgan on 05/12/2018.
//

import Foundation

/// Mirror Yummly's JSON structure
struct Recipes: Decodable {
    var matches: [Recipe]
    var totalMatchCount: Int

    struct Recipe: Decodable {
        var recipeName: String
        var id: String
        var rating: Int?
        var totalTimeInSeconds: Int?
        var smallImageUrls: [String]?
    }
}
