//
//  RecipeService.swift
//  Reciplease
//
//  Created by Morgan on 14/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation
import Alamofire

struct RecipeService: Serviceable {
    static func request(with item: String, callback: @escaping RecipeService.Callback) {
        Alamofire.request(createURL(with: item)).responseJSON { response in
            response.result.ifFailure {
                callback(false, nil)
            }
            response.result.ifSuccess {
                let resource = parse(response.data!)
                callback(true, resource)
            }
        }
    }

    /// Build a URL and return a  URLRequest to access Yummly recipes list
    static func createURL(with item: String) -> URL {
        let ingredients = item.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = APIAssets.searchEndpoint
            + APIAssets.credentials
            + APIAssets.search
            + ingredients!

        print("completeURL", completeURL)

        return URL(string: completeURL)!
    }
}

extension RecipeService {
    /// Decode data, return recipes
    static func parse(_ data: Data) -> Recipes {
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
