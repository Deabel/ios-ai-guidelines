// MARK: - FeatureService Template
// Replace every occurrence of "Feature" with your actual feature name.
// Delete this comment block before committing.

import Foundation

// MARK: - Protocol (for testability and DI)

protocol FeatureServiceProtocol {
    func fetchItems() async throws -> [FeatureItem]
    func saveItem(_ item: FeatureItem) async throws
    func deleteItem(id: Int64) async throws
}

// MARK: - Concrete Implementation

final class FeatureService: FeatureServiceProtocol {

    // MARK: - Dependencies
    // Inject database / network client via init — no singletons.

    private let database: DatabaseQueue  // Replace with your actual DB type (e.g. GRDB DatabaseQueue)

    init(database: DatabaseQueue) {
        self.database = database
    }

    // MARK: - FeatureServiceProtocol

    func fetchItems() async throws -> [FeatureItem] {
        // Example GRDB fetch:
        // try await database.read { db in
        //     try FeatureItem.fetchAll(db)
        // }
        fatalError("Implement fetchItems()")
    }

    func saveItem(_ item: FeatureItem) async throws {
        // Example GRDB write:
        // try await database.write { db in
        //     try item.save(db)
        // }
        fatalError("Implement saveItem(_:)")
    }

    func deleteItem(id: Int64) async throws {
        // Example GRDB delete:
        // try await database.write { db in
        //     try FeatureItem.deleteOne(db, id: id)
        // }
        fatalError("Implement deleteItem(id:)")
    }
}
