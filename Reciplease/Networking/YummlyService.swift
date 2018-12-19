//
//  YummlyService.swift
//  Reciplease
//
//  Created by Morgan on 04/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Call Yummly

/// Call Yummly API
struct YummlyService {
    typealias Callback = (Bool, Any?) -> Void
    /**
     Perform an API call with Alamofire

     - Parameters:
        - ingredients: The user input
        - callback: Provide the state of the API response
 */
    static func getRecipes(with ingredients: String, callback: @escaping Callback) {
        Alamofire.request(createURL(with: ingredients)).responseJSON { response in
            print("getRecipes result: \(response.result.description)")
            response.result.ifFailure {
                callback(false, nil)
            }
            response.result.ifSuccess {
                let resource = parse(response.data!)
                callback(true, resource)
            }
        }
    }

    /**
     Call Yummly to get recipes thumbnails

     - Parameters:
        - location: Thumbnails URLs
        - callback: Provide the state of the network call
     */
    static func getThumbnail(from location: [String]?, callback: @escaping Callback) {
        guard let location = location?[0] else {
            callback(false, nil)
            return
        }

        let url = URL(string: location)!
        print("thumbnails urls:\(url)")
        
        Alamofire.request(url).responseData { response in
          print("getThumbnail result: \(response.result.description)")
            response.result.ifFailure {
                callback(false, nil)
            }
            response.result.ifSuccess {
                let resource = UIImage(data: response.data!)
                print("resource: \(String(describing: resource))")
                callback(true, resource)
            }
        }
    }
}

// MARK: - Create URL

extension YummlyService {
    /// Create a  URLRequest to access Yummly resources
    static private func createURL(with ingredients: String) -> URLRequest {
        let ingredients = ingredients.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = APIAssets.endpoint
            + APIAssets.credentials
            + APIAssets.search
            + ingredients!

        let url = URL(string: completeURL)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        return request
    }
}

// MARK: - Parse JSON

extension YummlyService {
    /// Decode data, return recipes
    static private func parse(_ data: Data) -> Recipes {
        let recipe = Recipes(matches: [], totalMatchCount: 0)

        do {
            let recipe = try JSONDecoder().decode(Recipes.self, from: data)
            return recipe
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

        return recipe
    }
}
