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
    static let endpoint = "https://api.yummly.com/v1/api/recipes?"
    static let credentials = "_app_id=\(Credentials.id)&_app_key=\(Credentials.key)"
    static let search = "&q="
}

