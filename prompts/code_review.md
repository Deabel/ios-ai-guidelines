# Prompt: Code Review

Use this prompt to ask AI to review existing Swift code against project standards.

---

## Prompt Template

```
Review the following Swift code against these project standards and list all violations:

**Standards to check:**
1. Architecture: View must not contain business logic or networking; only ViewModel and Service may
2. SwiftUI: Views must be < ~150 lines; complex UI must be split into subviews
3. State: @State for local UI, @StateObject to own ViewModel, @ObservedObject for injected
4. Concurrency: async/await preferred; UI updates on @MainActor; avoid Task.detached
5. Combine: only for search streams, timers, event pipelines; not for networking
6. Naming: Views → *View, ViewModels → *ViewModel, Services → *Service; async funcs start with verbs
7. Anti-patterns: no global singletons, no massive ViewModels, no mixed Combine + async/await

**Output format:**
For each violation found:
- File/location
- Rule violated
- What the code currently does
- Recommended fix (with code snippet if helpful)

If no violations are found, say so explicitly.

**Code to review:**
[paste your code here]
```
