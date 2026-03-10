// MARK: - FeatureView Template
// Replace every occurrence of "Feature" with your actual feature name.
// Delete this comment block before committing.

import SwiftUI

struct FeatureView: View {

    // Use @StateObject only if this view *owns* the ViewModel.
    // Switch to @ObservedObject if the ViewModel is injected from outside.
    @StateObject private var viewModel = FeatureViewModel(service: FeatureService())

    var body: some View {
        content
            .navigationTitle("Feature")
            .task {
                await viewModel.fetchData()
            }
    }
}

// MARK: - Subviews

private extension FeatureView {

    @ViewBuilder
    var content: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let errorMessage = viewModel.errorMessage {
            ErrorView(message: errorMessage)
        } else {
            listView
        }
    }

    var listView: some View {
        List(viewModel.items) { item in
            FeatureRowView(item: item)
        }
    }
}

// MARK: - Row Subview

private struct FeatureRowView: View {
    let item: FeatureItem

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.body)
            Text(item.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        FeatureView()
    }
}
