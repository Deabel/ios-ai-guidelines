# Prompt: New Feature Scaffold

Use this prompt when you need to create a complete feature from scratch.

---

## Prompt Template

```
Create a new iOS feature called "[FeatureName]" following these rules:

**Context:**
- Feature description: [describe what this feature does]
- Input data: [describe the data this feature receives or fetches]
- Output/actions: [describe what the user can do]

**Required files:**
1. [FeatureName]View.swift — SwiftUI View
2. [FeatureName]ViewModel.swift — ViewModel
3. [FeatureName]Service.swift — Service (if networking or data access is needed)

**Rules to follow:**
- Architecture: MVVM + Service Layer (View → ViewModel → Service → Network)
- Views: SwiftUI only, max ~150 lines, no business logic
- State: @StateObject to own ViewModel, @ObservedObject for injected dependencies
- Concurrency: async/await for all async work; @MainActor for UI updates
- Combine: only for search input streams, timers, or event pipelines
- Naming: Views end in "View", ViewModels end in "ViewModel", Services end in "Service"
- Async functions start with verbs: fetch, load, update, delete
- No global singletons; use dependency injection
- Do not mix Combine and async/await in the same logic path

**Output format:**
Provide each file separately with its filename as the header.
```

---

## Example

```
Create a new iOS feature called "BloodPressure" following these rules:

**Context:**
- Feature description: Display a list of blood pressure records; allow the user to add a new reading
- Input data: BloodPressureRecord fetched from local SQLite via GRDB
- Output/actions: List view with add button; tapping a row navigates to a detail view

**Required files:**
1. BloodPressureListView.swift
2. BloodPressureListViewModel.swift
3. BloodPressureService.swift
```
