//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Morgan on 05/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    // MARK: - Properties

    /// Array of favorite recipes fetched from core data
    var favorites = Favorite.all

    var recipeID = ""
    var recipeName = ""
    var recipeRating = ""
    var recipeTime = ""

    @IBOutlet weak var favoriteTableView: UITableView!

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.reloadData()

//        Favorite.deleteAll()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = Favorite.all
        favoriteTableView.reloadData()
    }
}

// MARK: - TableView Data Source

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if favorites.count == 0
        // tell user how to create favs
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIID.cell.listCell,
                                                       for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        let favorite = favorites[indexPath.row]

        cell.configure(image: UIImage(data: favorite.image!)!,
                       name: favorite.name!,
                       ingredients: favorite.ingredients!,
                       rating: favorite.rating!,
                       time: favorite.time!)

        return cell
    }
}

// MARK: - Segue to DetailVC

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let favorite = favorites[indexPath.row]

        recipeID = favorite.id!
        recipeName = favorite.name!
        recipeRating = favorite.rating!
        recipeTime = favorite.time!

        performSegue(withIdentifier: UIID.segue.presentDetailedRecipe, sender: cell)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UIID.segue.presentDetailedRecipe {
            let detailVC = segue.destination as! DetailViewController
            detailVC.detailedRecipeID = recipeID
            detailVC.detailedRecipeName = recipeName
            detailVC.detailedRecipeRating = recipeRating
            detailVC.detailedRecipeTime = recipeTime
        }
    }
}
