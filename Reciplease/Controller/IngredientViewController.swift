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
    /// Default textView string
    var textViewPlaceHolder: String {
        return "Add your ingredients"
    }

    /// Reference Clear and Done buttons
    @IBOutlet weak var buttons: UIButton!
    /// Ingredients list
    @IBOutlet weak var ingredientTextView: UITextView!

    // MARK: - Actions

    /// Clear ingredients list
    @IBAction func clearButton(_ sender: Any) {
        ingredientTextView.text = textViewPlaceHolder
        ingredientTextView.resignFirstResponder()
    }

    /// Trigger a segue to RecipeViewController
    @IBAction func doneButton(_ sender: UIButton) {}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UIID.segue.showRecipeVC {
            let recipeVC = segue.destination as! RecipeViewController

            sendIngredients(to: recipeVC)
        }
    }

    private func sendIngredients(to recipeVC: RecipeViewController) {
        if ingredientTextView.text == textViewPlaceHolder {
            recipeVC.ingredients = ""
        } else {
            recipeVC.ingredients = ingredientTextView.text
        }
    }
}

// MARK: - textView

extension IngredientViewController: UITextViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextView.delegate = self
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        ingredientTextView.text = ""
    }
}
