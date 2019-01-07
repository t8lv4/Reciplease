//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Morgan on 05/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    // MARK: - Properties

    /// Array of favorite recipes fetched from core data
    var favorites = Favorite.all

    @IBOutlet weak var favoriteTableView: UITableView!

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favorites = Favorite.all
        favoriteTableView.reloadData()
    }
}

// MARK: - TableView Data Source

extension FavoriteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if favorites.count == 0
        // tell user how to create favs
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIID.cell.listCell,
                                                       for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        let favorite = favorites[indexPath.row]

        cell.configure(image: UIImage(data: favorite.image!)!,
                       name: favorite.name!,
                       ingredients: favorite.ingredients!,
                       rating: favorite.rating!,
                       time: favorite.time!)

        return cell
    }
}
