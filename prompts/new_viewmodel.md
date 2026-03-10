# Prompt: New ViewModel

Use this prompt when you need a ViewModel for an existing or planned View.

---

## Prompt Template

```
Create a ViewModel called "[FeatureName]ViewModel" with the following requirements:

**Context:**
- Feature: [what feature this ViewModel belongs to]
- Data it manages: [list the state properties, e.g. records: [Record], isLoading: Bool, errorMessage: String?]
- Actions the View can trigger: [e.g. load data on appear, delete a record, submit a form]
- Dependencies: [list injected services, e.g. WeightService, UserService]

**Rules:**
- Annotate the class with @MainActor
- Use @Published for all properties observed by the View
- Async methods use async/await; no Combine for networking
- Combine is allowed only for search/debounce input streams
- No business logic that belongs in the Service layer
- Dependencies are injected via initializer (no singletons)
- Async function names start with verbs: fetchX, loadX, updateX, deleteX
```

---

## Example

```
Create a ViewModel called "SleepRecordViewModel" with the following requirements:

**Context:**
- Feature: Sleep tracking history list
- Data it manages: records: [SleepRecord], isLoading: Bool, errorMessage: String?
- Actions: fetchRecords() on appear, deleteRecord(_ id: Int64)
- Dependencies: SleepService
```
