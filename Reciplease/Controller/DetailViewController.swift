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

    /// Recipe's name
    @IBOutlet weak var detailedRecipeNameLabel: UILabel!
    /// Recipe's servings number
    @IBOutlet weak var detailedRecipeServingsLabel: UILabel!
    /// Recipe's rating or empty string
    @IBOutlet weak var detailedRecipeRatingLabel: UILabel!
    /// Recipe's execution time or empty string
    @IBOutlet weak var detailedRecipeTimeLabel: UILabel!
    /// Hold an ingredients list
    @IBOutlet weak var ingredientsTextView: UITextView!
    /// Favorite button
    @IBOutlet weak var favoriteButton: UIButton!
    /// Recipe's image if available, else a default image
    @IBOutlet weak var detailedRecipeImageView: UIImageView!
    

    // MARK: - Methods
    
    /// Dismiss viewController
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /// Get recipe directions
    @IBAction func getDirections(_ sender: Any) {
            let url = URL(string: detailedRecipeURL)!
            UIApplication.shared.open(url)
    }
    /// Add recipe to favorite recipes
    @IBAction func createFavorite(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailedRecipeNameLabel.text = self.detailedRecipeName
        self.detailedRecipeRatingLabel.text = self.detailedRecipeRating
        self.detailedRecipeTimeLabel.text = self.detailedRecipeTime
    }
}

extension DetailViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        YummlyService.getRecipe(with: detailedRecipeID) { (success, resource) in
            if success, let detailedRecipe = resource as? DetailedRecipe {
                self.detailedRecipeURL = detailedRecipe.source.sourceRecipeUrl
                self.updateUI(with: detailedRecipe)
            } else {
                // alert user
            }
        }
    }

    /**
     Update UI objects with recipe elements fetched from Yummly
     */
    private func updateUI(with detailedRecipe: DetailedRecipe) {
        self.detailedRecipeServingsLabel.text = Unwrapper.unwrap(.servings, for: detailedRecipe)
        self.ingredientsTextView.text = detailedRecipe.ingredientLines.joined(separator: "\n")
        YummlyService.getImage(for: self.detailedRecipeImageView, from: detailedRecipe.images[0].hostedLargeUrl)
    }
}
