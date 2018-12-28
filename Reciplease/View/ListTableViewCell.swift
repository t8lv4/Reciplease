//
//  ListTableViewCell.swift
//  Reciplease
//
//  Created by Morgan on 03/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    /// Recipe's image
    @IBOutlet weak var recipeImage: UIImageView!
    /// Contains recipe's name, ingredients, rating and preparation time
    @IBOutlet weak var containerView: UIView!
    /// Recipe's name
    @IBOutlet weak var nameLabel: UILabel!
    /// Ingredients name
    @IBOutlet weak var ingredientLabel: UILabel!
    /// Recipe's rating
    @IBOutlet weak var ratingLabel: UILabel!
    /// Preparation time
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // add shadows and rounded corners
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ListTableViewCell {
    /// Configure custom cell's elements to display
    func configure(image: UIImage, name: String, ingredients: String, rating: String, time: String) {
        recipeImage.image = image
        nameLabel.text = name
        ingredientLabel.text = ingredients
        ratingLabel.text = rating
        timeLabel.text = time
    }
}
