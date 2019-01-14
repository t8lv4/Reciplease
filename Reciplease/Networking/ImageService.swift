//
//  ImageService.swift
//  Reciplease
//
//  Created by Morgan on 14/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation
import Nuke

struct ImageService {
    /**
     Call to download an image linked to a recipe

     - parameter view: Display the image
     - parameter recipeURL: The image location
     */
    static func getImage(for view: UIImageView, from recipeURL: String?) {
        guard let url = URL(string: recipeURL!) else {
            print("wrong url")
            return
        }

        let options = ImageLoadingOptions(
            placeholder: UIImage(named: Image.defaultImage.rawValue),
            transition: .fadeIn(duration: 0.3)
        )

        Nuke.loadImage(with: url,
                       options: options,
                       into: view)
    }
}
