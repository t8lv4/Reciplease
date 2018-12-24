//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Morgan on 17/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    /// Recipe ID
    var detailedRecipeID = ""

    /// Favorite button
    @IBOutlet weak var favoriteButton: UIButton!

    /// Dismiss viewController
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /// Get recipe directions
    @IBAction func getDirections(_ sender: Any) {
    }
    /// Add recipe to favorite recipes
    @IBAction func createFavorite(_ sender: Any) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
