//
//  Favorite.swift
//  Reciplease
//
//  Created by Morgan on 05/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import Foundation
import CoreData

/// Core Data manager
class Favorite: NSManagedObject {
    // MARK: - Properties

    private static var searchArray: [Favorite]!

    static var all: [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        guard let favorites = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return favorites
    }
}

// MARK: - Search

extension Favorite {
    /// Search for ingredients (case and diacritic insensitive)
    /// - Returns: An array of favorite recipes, alphabetically sorted by `name`
    static func search(_ ingredientsList: String) -> [Favorite] {
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "ingredientsList CONTAINS[cd] %@", ingredientsList)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]

        do { searchArray = try AppDelegate.viewContext.fetch(request) }
        catch { print("unable to fetch search request: ", error) }

        return searchArray
    }
}

// MARK: - Delete all favorites

extension Favorite {
    /// Delete all stored recipes
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let delete = NSBatchDeleteRequest(fetchRequest: Favorite.fetchRequest())
        do { try viewContext.execute(delete) }
        catch { print("unable to delete all stored objects: ", error) }
    }
}
