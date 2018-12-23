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
}

//MARK: - Get Thumbnail

extension YummlyService {
    /**
     Call to download the thumnail linked to a recipe

     - parameter cell: Display the image
     - parameter recipe: The recipe associated with the image
     */
    static func getThumbnail(for cell: ListTableViewCell, and recipe: Recipes.Recipe) {
        let url = URL(string: recipe.smallImageUrls![0])!
        let options = ImageLoadingOptions(
            placeholder: UIImage(named: Image.defaultThumbnail.rawValue),
            transition: .fadeIn(duration: 0.5)
        )

        Nuke.loadImage(with: url,
                       options: options,
                       into: cell.recipeImage)
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
