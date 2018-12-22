//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Morgan on 28/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit
import Nuke

/// List recipes
class RecipeViewController: UIViewController {
    /// List of ingredients from IngredientViewController
    var ingredients = String()
    /// Yummly search parameter
    var ingredientsList = ""
    /// A recipes array
    var recipes = Recipes(matches: [], totalMatchCount: 0)
    /// Display recipes
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - API call

extension RecipeViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        requestRecipes()
    }

    /// Call Yummly API with an ingredients list
    private func requestRecipes() {
        ingredientsList = ingredients.format(with: " ")
        YummlyService.getRecipes(with: ingredientsList) { (success, resource) in
            if success, let resource = resource {
                self.recipes = resource as! Recipes
                self.tableView.reloadData()
            } else {
                // alert user
            }
        }
    }
}

// MARK: - Table View

extension RecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.matches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIID.cell.listCell,
                                                       for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        let recipe = recipes.matches[indexPath.row]
        ingredientsList = ingredients.format(with: ", ") + ", ..."

        configureCell(for: cell, and: recipe, with: ingredientsList)
        getThumbnail(for: cell, and: recipe)

        return cell
    }

    private func configureCell(for cell: ListTableViewCell, and recipe: Recipes.Recipe, with ingredients: String) {
        var ratingString: String {
            if let rating = recipe.rating {
                return String(rating) + " ⭐️"
            } else {
                return "n/a"
            }
        }

        var timeString: String {
            if let time = recipe.totalTimeInSeconds {
                return String(time / 60) + "'"
            } else {
                return "n/a"
            }
        }

        cell.configure(image: .init(),
                       name: recipe.recipeName,
                       ingredients: ingredientsList,
                       rating: ratingString,
                       time: timeString)
    }

    private func getThumbnail(for cell: ListTableViewCell, and recipe: Recipes.Recipe) {
        let url = URL(string: recipe.smallImageUrls![0])!
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: Image.defaultThumbnail.rawValue),
            transition: .fadeIn(duration: 0.5)
        )

        Nuke.loadImage(with: url,
                       options: options,
                       into: cell.recipeImage)
    }
}
