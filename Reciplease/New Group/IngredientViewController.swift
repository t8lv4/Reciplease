//
//  IngredientViewController.swift
//  Reciplease
//
//  Created by Morgan on 27/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {

    @IBOutlet weak var buttons: UIButton!
    
    @IBOutlet weak var IngredientTextView: UITextView!
    

    @IBAction func clearButton(_ sender: UIButton) {
    }


    @IBAction func doneButton(_ sender: UIButton) {
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        // set buttons corners and shadows
    }
}

extension IngredientViewController: UITextViewDelegate {

}
