//
//  Serviceable.swift
//  Reciplease
//
//  Created by Morgan on 14/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation

protocol Serviceable {
    typealias Callback = (Bool, Any?) -> Void
    /**
     Perform an API call with Alamofire

     - Parameters:
        - item: The user input
        - callback: Provide the state of the API response
     */
    static func request(with item: String, callback: @escaping Callback)
    /// Build and return a  URL to access a Yummly API resources
    static func createURL(with item: String) -> URL
}
