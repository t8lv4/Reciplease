//
//  DetailService.swift
//  Reciplease
//
//  Created by Morgan on 14/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation
import Alamofire

struct DetailService: Serviceable {
    static func request(with item: String, callback: @escaping DetailService.Callback) {
        Alamofire.request(createURL(with: item)).responseJSON { response in
            response.result.ifFailure {
                callback(false, nil)
            }
            response.result.ifSuccess {
                let resource = parseDetailedRecipe(response.data!)
                callback(true, resource)
            }
        }
    }

    static func createURL(with item: String) -> URL {
        let completeURL = APIAssets.getEndpoint
            + item
            + APIAssets.get
            + APIAssets.credentials

        return URL(string: completeURL)!
    }
}

extension DetailService {
    /// Decode data, return a detailed recipe
    static private func parseDetailedRecipe(_ data: Data) -> DetailedRecipe {
        let source = DetailedRecipe.Source.init(sourceRecipeUrl: "")
        let images = DetailedRecipe.Images.init(hostedLargeUrl: "")
        let detailedRecipe = DetailedRecipe(ingredientLines: [""],
                                            numberOfServings: 0,
                                            source: source,
                                            images: [images])

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
