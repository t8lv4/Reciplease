//
//  UIID.swift
//  Reciplease
//
//  Created by Morgan on 07/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Hold lists if UI identifiers
enum UIID {
    /// List segues IDs
    enum segue {
        static let showRecipeVC = "showRecipeVC"
    }

    /// List view controllers IDs
    enum ViewController {
        static let tabBarController = "tabBarController"
        static let recipeNavigation = "recipeNavigation"
        static let favoriteNavigation = "favoriteNavigation"
        static let ingredient = "ingredient"
        static let recipe = "recipe"
    }

    enum cell {
        static let listCell = "listCell"
    }
}
