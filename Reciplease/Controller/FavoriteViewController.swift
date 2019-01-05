//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Morgan on 05/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIID.cell.listCell,
                                                       for: indexPath) as? ListTableViewCell else { return UITableViewCell() }

        cell.configure(image: UIImage(named: Image.defaultThumbnail.rawValue)!,
                       name: "recipe.recipeName",
                       ingredients: "ingredientsList",
                       rating: "4",
                       time: "120")

        return cell
    }
}
