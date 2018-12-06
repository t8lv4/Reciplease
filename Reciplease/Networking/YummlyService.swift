//
//  YummlyService.swift
//  Reciplease
//
//  Created by Morgan on 04/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation
import Alamofire

/// Call Yummly API
struct YummlyService {
    /// Perform an API call with Alamofire
    static func call(with ingredients: String) {
        Alamofire.request(getRecipies(with: ingredients)).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }

            parse(response.data!)
        }
    }
}

extension YummlyService {
    /// Create a  URLRequest to access Yummly resources
    static private func getRecipies(with ingredients: String) -> URLRequest {
        let ingredients = ingredients.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = APIAssets.endpoint
            + APIAssets.credentials
            + APIAssets.search
            + ingredients!

        let url = URL(string: completeURL)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        print(completeURL)

        return request
    }
}

extension YummlyService {
    /// Decode data
    @discardableResult static func parse(_ data: Data) -> Any {

        do {
           let json = try JSONDecoder().decode(Recipe.self, from: data)
            print("\(json.matches)\n\(json.matches.count)\n\(json.totalMatchCount)")

            print(":::::::::\(json.matches[9].id)")

        } catch DecodingError.dataCorrupted(let context) {
            print(context.debugDescription)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("\(key.stringValue) was not found, \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("\(type) was expected, \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("no value was found for \(type), \(context.debugDescription)")
        } catch {
            print("Unknown error")
        }

        return 1
    }
}
