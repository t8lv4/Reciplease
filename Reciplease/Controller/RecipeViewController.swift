//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Morgan on 28/11/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import UIKit

/// List recipies
class RecipeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // call API
    }

}

extension RecipeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1// recipies count from API
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }

        // call cell.configure(imag:name:ingredients:rating:time)
        
        return cell
    }
}
