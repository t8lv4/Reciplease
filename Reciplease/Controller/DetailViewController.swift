//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Morgan on 17/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

/// Handle the detailed Recipe view
class DetailViewController: UIViewController {
    // MARK: - Properties

    /// A detailed favorite recipe
    var detailedFavorite: Favorite!

    /// A detailed recipe source location, required by the Yummly API.
    /// Let user get recipe directions.
    var detailedRecipeURL = ""
    /// Hold value from RecipeViewController
    var detailedRecipeID = ""
    /// Hold value from RecipeViewController
    var detailedRecipeName = ""
    /// Hold value from RecipeViewController
    var detailedRecipeRating = ""
    /// Hold value from RecipeViewController
    var detailedRecipeTime = ""
    /// Hold value from RecipeViewController
    var detailedRecipeIngredientsList = ""
    /// Check favoriteButton states
    var detailedRecipeIsFavorite = false

    /// Recipe's name
    @IBOutlet weak var detailedRecipeNameLabel: UILabel!
    /// Recipe's servings number
    @IBOutlet weak var detailedRecipeServingsLabel: UILabel!
    /// Recipe's rating or n/a
    @IBOutlet weak var detailedRecipeRatingLabel: UILabel!
    /// Recipe's execution time or n/a
    @IBOutlet weak var detailedRecipeTimeLabel: UILabel!
    /// Hold ingredients list
    @IBOutlet weak var ingredientsTextView: UITextView!
    /// Favorite button
    @IBOutlet weak var favoriteButton: UIButton!
    /// Recipe's image if available, else a default image
    @IBOutlet weak var detailedRecipeImageView: UIImageView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    

    // MARK: - Methods
    
    /// Dismiss viewController
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /// Open default web browser to get recipe directions
    @IBAction func getDirections(_ sender: Any) {
            let url = URL(string: detailedRecipeURL)!
            UIApplication.shared.open(url)
    }
    /// Add recipe to favorite recipes
    @IBAction func toggleFavorite(_ sender: Any) {
        if !favoriteButton.isSelected {
            favoriteButton.isSelected = true
            storeFavorite()
        } else {
            favoriteButton.isSelected = false
            deleteFavorite()
        }
    }
}

// MARK: - Call API

extension DetailViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if detailedRecipeIsFavorite {
            favoriteButton.isSelected = true
        }

        callAPI()
    }

    /**
     Call Yummly API to get a detailed recipe

     If failed, alert user.
     */
    private func callAPI() {
        toggleActivityIndicator(activityIndicatorView, shown: true)

        YummlyService.getRecipe(with: detailedRecipeID) { (success, resource) in
            self.toggleActivityIndicator(self.activityIndicatorView, shown: false)

            if success, let detailedRecipe = resource as? DetailedRecipe {
                self.detailedRecipeURL = detailedRecipe.source.sourceRecipeUrl
                self.updateUI(with: detailedRecipe)
            } else {
                self.cleanUI()
                self.presentVCAlert(with: AlertTitle.networking.rawValue, and: AlertMessage.networking.rawValue)
            }
        }
    }
}

    // MARK: - Update UI

extension DetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailedRecipeNameLabel.text = self.detailedRecipeName
        self.detailedRecipeRatingLabel.text = self.detailedRecipeRating
        self.detailedRecipeTimeLabel.text = self.detailedRecipeTime
    }

    /**
     Update UI objects with recipe elements fetched from Yummly
     */
    private func updateUI(with detailedRecipe: DetailedRecipe) {
        self.detailedRecipeServingsLabel.text = Unwrapper.unwrap(.servings, for: detailedRecipe)
        self.ingredientsTextView.text = detailedRecipe.ingredientLines.joined(separator: "\n")
        YummlyService.getImage(for: self.detailedRecipeImageView,
                               from: detailedRecipe.images[0].hostedLargeUrl)
    }

    private func cleanUI() {
        ingredientsTextView.text = ""
        favoriteButton.isHidden = true
        getDirectionsButton.isHidden = true
        ingredientLabel.isHidden = true
    }
}

// MARK: - Save / Delete favorite data

extension DetailViewController {
    /// Store favorite recipe data to Reciplease data model
    private func storeFavorite() {
        detailedFavorite = Favorite(context: AppDelegate.viewContext)
        
        detailedFavorite.isFavorite = true
        detailedFavorite.id = detailedRecipeID
        detailedFavorite.name = detailedRecipeName
        detailedFavorite.rating = detailedRecipeRating
        detailedFavorite.time = detailedRecipeTime
        detailedFavorite.ingredients = detailedRecipeIngredientsList
        detailedFavorite.servings = detailedRecipeServingsLabel.text
        detailedFavorite.image = (detailedRecipeImageView.image ?? UIImage(named: Image.defaultImage.rawValue)!).pngData()

        do { try AppDelegate.viewContext.save() }
        catch { print("unable to store favorite: \(error)")}
    }

    private func deleteFavorite() {
        detailedFavorite.managedObjectContext?.delete(detailedFavorite)
        
        do { try AppDelegate.viewContext.save()}
        catch { print("unable to delete favorite: \(error)") }
    }
}
