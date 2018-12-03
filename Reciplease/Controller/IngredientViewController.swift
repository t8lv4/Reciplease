//
//  IngredientViewController.swift
//  Reciplease
//
//  Created by Morgan on 27/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {
    /// Reference Clear and Done buttons
    @IBOutlet weak var buttons: UIButton!
    /// Ingredients list
    @IBOutlet weak var ingredientTextView: UITextView!
    /// Clear ingredients list
    @IBAction func clearButton(_ sender: Any) {
        ingredientTextView.text = ""
    }

    /// Create &q= and present RecipeViewController
    @IBAction func doneButton(_ sender: UIButton) {
        // create &q= with ingredients
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientTextView.delegate = self
        // set buttons corners and shadows
    }
}

extension IngredientViewController: UITextViewDelegate {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        ingredientTextView.text = ""
    }
}
