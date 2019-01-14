//
//  AlertVCMessageEnum.swift
//  Reciplease
//
//  Created by Morgan on 13/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation

enum AlertTitle: String {
    case networking = "🤔"
    case emptyFavorite = "Create Your Favorites!"
    case noRecipe = "😯"
}

enum AlertMessage: String {
    case networking = "Looks like there's a networking issue"
    case emptyFavorite = """
    To create a favorite recipe,
    tap the 💛 button on the recipe page.
    """
    case noRecipe = "No recipe matches your ingredients list."
}
