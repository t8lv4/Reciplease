//
//  YummlyService.swift
//  Reciplease
//
//  Created by Morgan on 04/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation
import Alamofire
import Nuke

// MARK: - Call Yummly

/// Handle networking calls
struct YummlyService {
    typealias Callback = (Bool, Any?) -> Void
    /**
     Perform an API call with Alamofire

     - Parameters:
        - ingredients: The user input
        - callback: Provide the state of the API response
     */
    static func searchRecipes(with ingredients: String, callback: @escaping Callback) {
        Alamofire.request(buildSearchURL(with: ingredients)).responseJSON { response in
            response.result.ifFailure {
                callback(false, nil)
            }
            response.result.ifSuccess {
                let resource = parseRecipes(response.data!)
                callback(true, resource)
            }
        }
    }

    /**
     Perform an API call with Alamofire

     - Parameters:
        - recipeID: The Yummly ID of a recipe
        - callback: Provide the state of the API response
     */
    static func getRecipe(with recipeID: String, callback: @escaping Callback) {
        Alamofire.request(buildGetURL(with: recipeID)).responseJSON { response in
            response.result.ifFailure {
                callback(false, nil)
            }
            response.result.ifSuccess {
                let resource = parseDetailedRecipe(response.data!)
                callback(true, resource)
            }
        }
    }
}

//MARK: - Get Image

extension YummlyService {
    /**
     Call to download an image linked to a recipe

     - parameter view: Display the image
     - parameter recipeURL: The image location
     */
    static func getImage(for view: UIImageView, from recipeURL: String?) {
        let url = URL(string: recipeURL!)!
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: Image.defaultImage.rawValue),
            transition: .fadeIn(duration: 0.3)
        )

        Nuke.loadImage(with: url,
                       options: options,
                       into: view)
    }
}

// MARK: - Create URLs

extension YummlyService {
    /// Build a URL and return a  URLRequest to access Yummly recipes list
    static private func buildSearchURL(with ingredients: String) -> URL {
        let ingredients = ingredients.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let completeURL = APIAssets.searchEndpoint
            + APIAssets.credentials
            + APIAssets.search
            + ingredients!

//        return YummlyService.createRequest(with: completeURL)
        return URL(string: completeURL)!
    }

    /// Build a URL and return a  URLRequest to access an Yummly detailed recipe
    static private func buildGetURL(with recipeID: String) -> URL {
        let completeURL = APIAssets.getEndpoint
            + recipeID
            + APIAssets.get
            + APIAssets.credentials

//        return YummlyService.createRequest(with: completeURL)
        return URL(string: completeURL)!
    }

//    /// Create a URLRequest
//    static private func createRequest(with completeURL: String) -> URLRequest {
//        let url = URL(string: completeURL)!
//        let request = URLRequest(url: url)
////        request.httpMethod = HTTPMethod.get.rawValue
//
//        return request
//    }
}

// MARK: - Parse JSON

extension YummlyService {
    /// Decode data, return recipes
    static private func parseRecipes(_ data: Data) -> Recipes {
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

    static private func parseDetailedRecipe(_ data: Data) -> DetailedRecipe {
        let source = DetailedRecipe.Source.init(sourceRecipeUrl: "")
        let images = DetailedRecipe.Images.init(hostedLargeUrl: "")
        let detailedRecipe = DetailedRecipe(ingredientLines: [""], numberOfServings: 0, source: source, images: [images])

        do {
            let detailedRecipe = try JSONDecoder().decode(DetailedRecipe.self, from: data)
            return detailedRecipe
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

        return detailedRecipe
    }
}
