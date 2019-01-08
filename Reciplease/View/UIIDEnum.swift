//
//  UIID.swift
//  Reciplease
//
//  Created by Morgan on 07/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Hold lists of UI identifiers
enum UIID {
    /// List segues IDs
    enum segue {
        static let showRecipeVC = "showRecipeVC"
        static let presentRecipeDetail = "presentRecipeDetail"
        static let presentDetailedRecipe = "presentDetailedRecipe"
    }

    /// List view controllers IDs
    enum ViewController {
        static let tabBarController = "tabBarController"
        static let recipeNavigation = "recipeNavigation"
        static let favoriteNavigation = "favoriteNavigation"
        static let ingredient = "ingredient"
        static let recipe = "recipe"
        static let detail = "detail"
        static let favorite = "favorite"
    }

    enum cell {
        static let listCell = "listCell"
    }
}
