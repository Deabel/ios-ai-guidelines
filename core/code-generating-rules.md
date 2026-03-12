# AI Context

These rules define how AI coding agents should generate Swift code for iOS projects.

## Baseline

All generated Swift code must conform to:

1. [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
2. Apple's Human Interface Guidelines (for UI decisions)
3. Apple framework documentation (for API usage patterns)

When these guidelines conflict with rules in this document, this document takes precedence.

## Primary Technologies

1. Swift
2. SwiftUI
3. Swift Structured Concurrency
4. UICompositionalLayout and UICollectionViewDiffableDataSource if required UIKit
5. Combine (only when reactive streams are required)

## Architecture Pattern

MVVM + Service Layer

Apply the classic 23 Gang of Four design patterns where appropriate.

Follow the KISS principle: on the foundation of maintainability and extensibility, simpler is always better.

# Architecture

Architecture pattern: MVVM + Service Layer

Layer order:

View → ViewModel → Service → Repository → Network / Local Storage

Rules:

- Views must be written using SwiftUI unless explicitly required to use UIKit.
- Views must not contain business logic.
- ViewModels manage state and business logic.
- Service orchestrates business logic and coordinates between repositories.
- Repository abstracts data sources (network, database, cache).
- ViewModels must not access Repository or Network directly.
- Services must be defined as protocols. Concrete implementations are injected.
- ViewModels should accept Service protocols via init, not create them internally.

Example flow:

View → ViewModel → Service → Repository → Network / Local Storage

---

# Anti Patterns

Avoid the following:

1. Massive ViewModels.
2. Networking inside Views.
3. Custom global singletons that hold mutable state. Use dependency injection instead. System-provided singletons (e.g. URLSession.shared) are acceptable.
4. Interleaving Combine operators and async/await within the same function. Bridging at boundaries (e.g. Publisher.values, checked continuations) is acceptable.
5. Business logic inside SwiftUI Views.
6. Using `try!` or force unwrap (`!`) in production code.
7. Bare `try?` that silently discards failures without logging or handling.
8. Static methods for anything that needs to be mocked or tested.
9. Leaving all access levels as implicit `internal`.

---

# Naming Rules

## General

- Naming should follow Apple's Swift API Design Guidelines.
- Name methods and functions based on their side effects:
  - No side effects → noun phrase: `distance(from:to:)`
  - Has side effects → imperative verb: `sort()`, `append(_:)`
- Mutating/non-mutating pairs: mutating uses verb (`sort()`), non-mutating uses -ed/-ing (`sorted()`, `removing(_:)`).
- Bool properties read as assertions: `isEmpty`, `isValid`, `isConnected`. Never `empty`, `valid`, `connected`, or `checkEmpty()`.
- Protocols describing capability use -able/-ible: `Equatable`, `Sendable`.
- Factory methods use `make` prefix: `makeIterator()`.
- Argument labels should form grammatical English at call site: `removeItem(at: index)` not `removeItem(index: index)`.
- Do not abbreviate: use `destination` not `dest`, `previous` not `prev`. Exception: universally accepted abbreviations like `URL`, `ID`, `min`, `max`.

## Type Naming

- Views must end with `View`. Example: `UserProfileView`
- ViewModels must end with `ViewModel`. Example: `UserProfileViewModel`
- Services must end with `Service`. Example: `UserService`
- Repositories must end with `Repository`. Example: `UserRepository`

## Method Naming

Async functions must start with verbs.

Examples:

- `fetchUsers()`
- `loadProfile()`
- `updateSettings()`

## Examples

### Good

```swift
func fetchUsers() async throws -> [User]
var isConnected: Bool
mutating func add(_ item: Item)
func adding(_ item: Item) -> Collection
func makeIterator() -> Iterator
removeItem(at: index)
```

### Bad — Do Not Generate

```swift
func getUsers() async throws -> [User]    // "get" prefix is Objective-C style
var connected: Bool                        // Bool should read as assertion
func addItem(item: Item)                   // redundant external label
func returnSortedArray() -> [Item]         // describes implementation, not intent
func fetchData()                           // too vague, name should reflect what is fetched
```

---

# SwiftUI Rules

Views must be small and composable.

Maximum recommended size: 150 lines.

Complex UI must be split into subviews.

Views must not contain business logic.

## State Management

- `@State` for local UI state.
- `@StateObject` for owning a ViewModel.
- `@ObservedObject` for injected dependencies.
- `@EnvironmentObject` for shared dependencies injected from ancestor views.
- `@Environment` for system-provided values (e.g. `colorScheme`, `dismiss`).

---

# Concurrency Rules

Preferred concurrency model: Swift Structured Concurrency

Rules:

- Use async/await for networking.
- UI updates must occur on `@MainActor`.
- Prefer `@MainActor` on ViewModel classes rather than annotating individual methods.
- Avoid `Task.detached` unless necessary.
- Use `TaskGroup` for parallel work.
- Avoid exposing callback-based APIs to ViewModels. When third-party or system frameworks require callbacks/delegates (e.g. Core Bluetooth, UIKit delegates), wrap them with `AsyncStream` or `withCheckedContinuation` at the Service layer.
- Use custom actors to protect shared mutable state instead of locks or serial `DispatchQueue`s.

---

# Combine Rules

Combine should be used only when appropriate.

Allowed scenarios:

- Search input streams
- Timer streams
- Event pipelines

Avoid using Combine for networking.

Prefer async/await for API requests.

---

# Error Handling Rules

- Never use `try!` or force unwrap (`!`) in production code.
- Define domain-specific error enums conforming to `LocalizedError`.
- ViewModels should expose error state for Views to display (e.g. a published `errorMessage` property).
- Use `do-catch` with meaningful error transformation, not bare `try?` that silently discards failures.
- `guard let` with early return is preferred over nested `if let`.

Example:

```swift
enum UserServiceError: LocalizedError {
    case networkUnavailable
    case unauthorized
    case serverError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .networkUnavailable:
            return "Network is unavailable."
        case .unauthorized:
            return "Authentication failed."
        case .serverError(let code):
            return "Server returned error \(code)."
        }
    }
}
```

---

# Access Control Rules

- Mark types and methods with the minimum required access level.
- ViewModel `@Published` properties should be `private(set)` where mutation is internal only.
- Service protocol definitions should be in a separate file from implementations.
- Use `private` for helper methods and internal state that should not be accessed outside the type.
- Use `fileprivate` only when access is needed across types in the same file.

Example:

```swift
@MainActor
final class UserProfileViewModel: ObservableObject {
    @Published private(set) var user: User?
    @Published private(set) var errorMessage: String?

    private let userService: UserServiceProtocol

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func loadProfile() async {
        do {
            user = try await userService.fetchCurrentUser()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
```

---

# Documentation Rules

- Add `///` documentation comments to all public and internal interfaces.
- Do not add inline comments for self-explanatory code.
- Use `// MARK: -` to organize type members by responsibility.
- The language of comments should be Chinese.

Example:

```swift
/// A service that manages user authentication and session lifecycle.
protocol AuthServiceProtocol {
    /// Authenticates the user with the given credentials.
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    /// - Returns: An authenticated `User` instance.
    /// - Throws: `AuthServiceError` if authentication fails.
    func signIn(email: String, password: String) async throws -> User
}
```

---

# Testing Guidance

- Services must be defined as protocols. Concrete implementations are injected.
- ViewModels should accept Service protocols via init, not create them internally.
- Avoid static methods for anything that needs to be mocked.
- Prefer pure functions where possible to simplify unit testing.

---

# Self-Review Checklist

Before finalizing generated code, verify:

- [ ] Every name reads naturally at the call site.
- [ ] Method naming follows Swift API Design Guidelines (side-effect rule, mutating/non-mutating pairs).
- [ ] Bool properties read as assertions (`is-`, `has-`, `can-`, `should-`).
- [ ] No force unwraps (`!`) unless the value is guaranteed by the compiler (e.g. `IBOutlet`).
- [ ] No bare `try?` that silently discards errors.
- [ ] Access control is explicitly specified (no implicit `internal` everywhere).
- [ ] `@Published` properties use `private(set)` where appropriate.
- [ ] All public interfaces have `///` documentation comments.
- [ ] Views contain no business logic.
- [ ] ViewModels do not directly access Network or Repository layers.
- [ ] Combine and async/await are not interleaved within the same function.
