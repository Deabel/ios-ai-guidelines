// MARK: - FeatureViewModel Template
// Replace every occurrence of "Feature" with your actual feature name.
// Delete this comment block before committing.

import Foundation

@MainActor
final class FeatureViewModel: ObservableObject {

    // MARK: - Published State

    @Published private(set) var items: [FeatureItem] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    // MARK: - Dependencies

    private let service: FeatureServiceProtocol

    // MARK: - Init

    init(service: FeatureServiceProtocol) {
        self.service = service
    }

    // MARK: - Intent Methods
    // Async function names start with verbs: fetch, load, update, delete.

    func fetchData() async {
        isLoading = true
        errorMessage = nil
        do {
            items = try await service.fetchItems()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func deleteItem(_ item: FeatureItem) async {
        do {
            try await service.deleteItem(id: item.id)
            items.removeAll { $0.id == item.id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
