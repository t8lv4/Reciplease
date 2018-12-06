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
            response.result.ifFailure {
                print("no data")
            }
            response.result.ifSuccess {
                let resource = parse(response.data!)
            }


//            switch response.result {
//            case .failure( _) : break
//            // alert user
//            case .success( _) :
//                if let json = response.result.value as? [String: Any] {
//                    print("JSON: \(json)")
//                }
//            }

            //  switch response.result == case failure ?
            // response.result.value == dictionnaire [String: Any]?

//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
//            }

//            let resource = parse(response.data!)
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
    @discardableResult static func parse(_ data: Data) -> Recipies {
        let recipe = Recipies(matches: [], totalMatchCount: 0)

        do {
            let recipe = try JSONDecoder().decode(Recipies.self, from: data)
            print("\(recipe.matches)\n\(recipe.matches.count)\n\(recipe.totalMatchCount)")
            print(":::::::::\(recipe.matches[9].id)")
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
