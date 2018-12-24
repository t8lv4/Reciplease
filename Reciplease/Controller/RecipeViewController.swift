//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Morgan on 28/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

/// List recipes
class RecipeViewController: UIViewController {
    /// List of ingredients from IngredientViewController
    var ingredients = String()
    /// Yummly search parameter
    var ingredientsList = ""
    /// A recipes array
    var recipes = Recipes(matches: [], totalMatchCount: 0)
    /// Recipe ID
    var recipeID = ""
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
        YummlyService.searchRecipes(with: ingredientsList) { (success, resource) in
            if success, let resource = resource {
                self.recipes = resource as! Recipes
                self.tableView.reloadData()
            } else {
                // alert user
            }
        }
    }
}

// MARK: - Table View Data Source

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
        YummlyService.getThumbnail(for: cell, and: recipe)

        return cell
    }

    /**
     Configure custom cell

     - parameter cell: The cell to configure
     - parameter recipe: Hold recipes image, rating and time values to display
     - parameter ingredients: The ingredients list
     */
    private func configureCell(for cell: ListTableViewCell, and recipe: Recipes.Recipe, with ingredients: String) {
        var ratingString: String {
            return Unwraper.unwrap(.rating, for: recipe)
        }

        var timeString: String {
            return Unwraper.unwrap(.time, for: recipe)
        }

        cell.configure(image: .init(),
                       name: recipe.recipeName,
                       ingredients: ingredientsList,
                       rating: ratingString,
                       time: timeString)
    }
}

// MARK: - Segue to DetailVC

extension RecipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        recipeID = recipes.matches[indexPath.row].id
        
        print("recipe id at selected row is: \(recipeID)")

        performSegue(withIdentifier: UIID.segue.presentRecipeDetail, sender: cell)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UIID.segue.presentRecipeDetail {
            let detailVC = segue.destination as! DetailViewController
            detailVC.detailedRecipeID = recipeID
        }
    }
}
