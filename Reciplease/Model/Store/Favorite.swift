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
    
}

// MARK: - Delete all favorites

extension Favorite {
    /// Delete all stored recipes
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let delete = NSBatchDeleteRequest(fetchRequest: Favorite.fetchRequest())
        do { try viewContext.execute(delete) }
        catch { print("unable to delete all stored objects: \(error)") }
    }
}
