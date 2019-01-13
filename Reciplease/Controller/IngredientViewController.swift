//
//  IngredientViewController.swift
//  Reciplease
//
//  Created by Morgan on 27/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

/// List ingredients
class IngredientViewController: UIViewController {
    // MARK: - Properties

    var userInput = String()

    /// Reference Clear and Done buttons
    @IBOutlet weak var buttons: UIButton!
    /// Ingredients list
    @IBOutlet weak var ingredientTextView: UITextView!

    // MARK: - Actions

    /// Clear ingredients list
    @IBAction func clearButton(_ sender: Any) {
        ingredientTextView.text = ""
    }

    /// trigger a segue to RecipeViewController
    @IBAction func doneButton(_ sender: UIButton) {}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UIID.segue.showRecipeVC {
            let showRecipeVC = segue.destination as! RecipeViewController
            showRecipeVC.ingredients = ingredientTextView.text
        }
    }
}

// MARK: - textView

extension IngredientViewController: UITextViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextView.delegate = self
        // set buttons corners and shadows
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        ingredientTextView.text = ""
    }
}
