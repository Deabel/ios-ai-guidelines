# AI Context

These rules define how AI coding agents should generate Swift code for
iOS projects.

Primary technologies:

1. Swift SwiftUI Swift Structured Concurrency Combine (only when reactive streams are required)

Architecture pattern:

1. MVVM + Service Layer

2. Apply the classic 23 Gang of Four design patterns where appropriate
3. Follow the KISS principle: on the foundation of maintainability and extensibility, simpler is always better.

Before generating code, the AI must follow the rules defined in:

1. architecture.md 
2. swiftui_rules.md 
3. concurrency_rules.md 
4. combine_rules.md
5. naming_rules.md 
6. anti_patterns.md

# Anti Patterns

Avoid the following:

1. Massive ViewModels
2. Networking inside Views
3. Global singletons
4. Mixing Combine and async/await in the same logic
5. Business logic inside SwiftUI Views

# Architecture

Architecture pattern:

MVVM + Service Layer

Layer order:

View ViewModel Service Network

Rules:

Views must be written using SwiftUI unless explicitly required to use UIKit.

Views must not contain business logic.

ViewModels manage state and business logic.

Networking must exist only in Service layer.

Views communicate only with ViewModels.

Example flow:

View -\> ViewModel -\> Service -\> Network

# Combine Rules

Combine should be used only when appropriate.

Allowed scenarios:

Search input streams Timer streams Event pipelines

Avoid using Combine for networking.

Prefer async/await for API requests.

# Concurrency Rules

Preferred concurrency model:

Swift Structured Concurrency

Rules:

Use async/await for networking.

UI updates must occur on MainActor.

Avoid Task.detached unless necessary.

Use TaskGroup for parallel work.

Avoid callback-based APIs.

# Naming Rules

Views must end with 'View'.

Example: UserProfileView

ViewModels must end with 'ViewModel'.

Example: UserProfileViewModel

Services must end with 'Service'.

Example: UserService

Async functions must start with verbs.

Examples:

fetchUsers() loadProfile() updateSettings()

Naming should follow Apple's programming guidelines.

# SwiftUI Rules

Views must be small and composable.

Maximum recommended size: 150 lines.

Complex UI must be split into subviews.

State management:

@State for local UI state.

@StateObject for owning a ViewModel.

@ObservedObject for injected dependencies.

Views must not contain business logic.
