//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Morgan on 05/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    // MARK: - Properties

    /// Array of favorite recipes fetched from core data
    var favorites = Favorite.all
    var favorite: Favorite!
    var searchArray: [Favorite]!
    /// To know if the user has already seen
    /// the pop-up alert
    var neverShown = true

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

        refreshFavoriteData()
        popUpAlert()
    }
}

extension FavoriteViewController {
    /// Reload tableView data and stored favorites
    private func refreshFavoriteData() {
        favorites = Favorite.all
        favoriteTableView.reloadData()
    }

    /// Present an alert VC
    private func popUpAlert() {
        if neverShown, favorites.count == 0 {
            presentVCAlert(title: .emptyFavorite, message: .emptyFavorite)
            neverShown = false
        }
    }
}

// MARK: - TableView Data Source

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIID.cell.listCell,
                                                       for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        favorite = favorites[indexPath.row]

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
        favorite = favorites[indexPath.row]

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
            detailVC.detailedFavorite = favorite
            detailVC.detailedRecipeID = recipeID
            detailVC.detailedRecipeName = recipeName
            detailVC.detailedRecipeRating = recipeRating
            detailVC.detailedRecipeTime = recipeTime
            detailVC.detailedRecipeIsFavorite = true
        }
    }
}

// MARK: - Swipe to delete cell

extension FavoriteViewController {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.viewContext.delete(favorites[indexPath.row])
            favorites.remove(at: indexPath.row)
            do { try AppDelegate.viewContext.save() }
            catch { print("unable to delete stored favorite: \(error)") }

            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - Search

extension FavoriteViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        favorites = search(searchBar.text!)
        favoriteTableView.reloadData()
    }

    private func search(_ ingredients: String) -> [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "ingredients CONTAINS[cd] %@", ingredients)
        request.sortDescriptors = [NSSortDescriptor(key: "ingredients", ascending: true)]

        do { searchArray = try AppDelegate.viewContext.fetch(request) }
        catch { print("unable to fetch search request", error) }

        return searchArray
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            favorites = Favorite.all
            favoriteTableView.reloadData()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
