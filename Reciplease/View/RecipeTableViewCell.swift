//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Morgan on 28/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

/// Define recipe cells held by the list Recipies View Controller
class RecipeTableViewCell: UITableViewCell {
    /// Recipe image. Use defaultImage if nil.
    @IBOutlet weak var hostedImageView: UIImageView!
    /// Hold labels
    @IBOutlet weak var containerView: UIView!
    /// Diplay recipes names
    @IBOutlet weak var recipeLabel: UILabel!
    /// Display some ingredients
    @IBOutlet weak var ingredientsLabel: UILabel!
    /// Display ratings
    @IBOutlet weak var ratingLabel: UILabel!
    /// Display preparation time plus cook time in minutes
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Add rounded corners and shadows
    }
}
