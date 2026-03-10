// MARK: - FeatureViewModelTests Template
// Replace every occurrence of "Feature" with your actual feature name.
// Delete this comment block before committing.

import Testing
@testable import YourAppModule

// MARK: - Mock

final class MockFeatureService: FeatureServiceProtocol {
    var stubbedItems: [FeatureItem] = []
    var shouldThrow = false
    var deleteCalledWithID: Int64?

    func fetchItems() async throws -> [FeatureItem] {
        if shouldThrow { throw TestError.stub }
        return stubbedItems
    }

    func saveItem(_ item: FeatureItem) async throws {
        if shouldThrow { throw TestError.stub }
    }

    func deleteItem(id: Int64) async throws {
        if shouldThrow { throw TestError.stub }
        deleteCalledWithID = id
    }
}

private enum TestError: Error { case stub }

// MARK: - Tests

@MainActor
struct FeatureViewModelTests {

    // MARK: fetchData

    @Test func fetchData_setsItemsOnSuccess() async {
        // Arrange
        let mock = MockFeatureService()
        mock.stubbedItems = [FeatureItem.stub()]
        let sut = FeatureViewModel(service: mock)

        // Act
        await sut.fetchData()

        // Assert
        #expect(sut.items.count == 1)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage == nil)
    }

    @Test func fetchData_setsErrorMessageOnFailure() async {
        // Arrange
        let mock = MockFeatureService()
        mock.shouldThrow = true
        let sut = FeatureViewModel(service: mock)

        // Act
        await sut.fetchData()

        // Assert
        #expect(sut.items.isEmpty)
        #expect(sut.isLoading == false)
        #expect(sut.errorMessage != nil)
    }

    // MARK: deleteItem

    @Test func deleteItem_removesItemFromList() async {
        // Arrange
        let item = FeatureItem.stub(id: 1)
        let mock = MockFeatureService()
        mock.stubbedItems = [item]
        let sut = FeatureViewModel(service: mock)
        await sut.fetchData()

        // Act
        await sut.deleteItem(item)

        // Assert
        #expect(sut.items.isEmpty)
        #expect(mock.deleteCalledWithID == 1)
    }
}

// MARK: - Test Helpers

private extension FeatureItem {
    static func stub(id: Int64 = 0) -> FeatureItem {
        // Replace with your actual model initializer
        FeatureItem(id: id, title: "Stub", subtitle: "Subtitle")
    }
}
