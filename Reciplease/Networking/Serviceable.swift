//
//  Serviceable.swift
//  Reciplease
//
//  Created by Morgan on 14/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation

/// Define methods to perform API calls
protocol Serviceable {
    typealias Callback = (Bool, Any?) -> Void
    /**
     Perform an API call with Alamofire

     - Parameters:
        - item: The user input
        - callback: Provide the state of the API response
     */
    static func request(with item: String, callback: @escaping Callback)
    /// Build and return a  URL to access Yummly API resources
    static func createURL(with item: String) throws -> URL?
    /// Decode JSON data thanks to a Decodable type
    static func parse<T: Decodable>(_ data: Data) -> T
}
