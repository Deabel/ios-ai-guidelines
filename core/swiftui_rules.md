# SwiftUI Rules

Views must be small and composable.

Maximum recommended size: 150 lines.

Complex UI must be split into subviews.

State management:

@State for local UI state.

@StateObject for owning a ViewModel.

@ObservedObject for injected dependencies.

Views must not contain business logic.
