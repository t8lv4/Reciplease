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

    /// Reference Clear and Done buttons
    @IBOutlet weak var buttons: UIButton!
    /// Ingredients list
    @IBOutlet weak var ingredientTextView: UITextView!

    // MARK: - Actions

    /// Clear ingredients list
    @IBAction func clearButton(_ sender: Any) {
        ingredientTextView.text = ""
    }
    /// Hold user input and show RecipeViewController
    @IBAction func doneButton(_ sender: UIButton) {
        if ingredientTextView.text == "" { return } // show alert
        else { getIngredients() }
    }

    private func getIngredients() {
        _ = ingredientTextView
            .text
            .replacingOccurrences(of: "\n", with: "")
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
