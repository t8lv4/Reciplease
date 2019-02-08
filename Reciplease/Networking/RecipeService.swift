//
//  RecipeService.swift
//  Reciplease
//
//  Created by Morgan on 14/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation
import Alamofire

/// Perform requests to search for recipes
struct RecipeService: Serviceable {
    private static let recipe = Recipes(matches: [], totalMatchCount: 0)

    static func request(with item: String, callback: @escaping RecipeService.Callback) {
        let url: URL!
        do {
            url = try createURL(with: item)
        } catch {
            return callback(false, nil)
        }
        
        Alamofire.request(url).responseJSON { response in
            response.result.ifFailure {
                callback(false, nil)
            }
            response.result.ifSuccess {
                let resource: Recipes = parse(response.data!)
                callback(true, resource)
            }
        }
    }

    static func createURL(with item: String) throws -> URL? {
        let ingredients = item.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = APIAssets.searchEndpoint
            + APIAssets.credentials
            + APIAssets.search
            + ingredients!

        print("completeURL", completeURL)

        return URL(string: completeURL)
    }

    static func parse<Recipes: Decodable>(_ data: Data) -> Recipes {
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

        return RecipeService.recipe as! Recipes
    }
}
