//
//  APIAssets.swift
//  Reciplease
//
//  Created by Morgan on 04/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

/// Assets to access API resources
enum APIAssets {
    static let searchEndpoint = "https://api.yummly.com/v1/api/recipes?"
    static let getEndpoint = "https://api.yummly.com/v1/api/recipe/"
    static let credentials = "_app_id=\(Credentials.id)&_app_key=\(Credentials.key)"
    static let search = "&q="
    static let get = "?"
}
