//
//  ListTableViewCell.swift
//  Reciplease
//
//  Created by Morgan on 03/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    /// Name the recipe image
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
