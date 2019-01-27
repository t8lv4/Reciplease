//
//  ImageService.swift
//  Reciplease
//
//  Created by Morgan on 14/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation
import Nuke

/// Perform a networking call to get images
struct ImageService {
    /**
     Call to download an image linked to a recipe

     - parameter view: Display the image
     - parameter recipeURL: The image location
     */
    static func getImage(for view: UIImageView, from recipeURL: String?) {
        guard let smallImageURL = recipeURL else {
            print("no small image url")
            return
        }
        guard let url = URL(string: smallImageURL) else {
            print("unable to create small image url")
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
