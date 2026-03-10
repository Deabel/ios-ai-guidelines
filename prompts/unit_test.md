# Prompt: Unit Tests

Use this prompt to generate unit tests for ViewModels or Services.

---

## Prompt Template

```
Write unit tests for "[ClassName]" using Swift Testing (or XCTest if the project uses it).

**Context:**
- Class under test: [ClassName] ([ViewModel / Service])
- Dependencies to mock: [list injected dependencies, e.g. MockWeightService]
- Scenarios to cover:
  1. [happy path description]
  2. [error/failure path description]
  3. [edge case description]

**Rules:**
- Mock all external dependencies via protocols
- Test async methods using async/await test functions
- Do not test UI; only test ViewModel state changes and Service logic
- Each test function name should describe the scenario: test_fetchRecords_returnsDataOnSuccess()
- Arrange / Act / Assert structure; add blank lines between sections
```

---

## Example

```
Write unit tests for "WeightViewModel" using Swift Testing.

**Context:**
- Class under test: WeightViewModel (ViewModel)
- Dependencies to mock: MockWeightService conforming to WeightServiceProtocol
- Scenarios to cover:
  1. fetchRecords() sets records and clears isLoading on success
  2. fetchRecords() sets errorMessage and clears isLoading on failure
  3. deleteRecord() removes the item from the records array
```
