# Prompts

Reusable AI prompt templates. Copy, fill in the placeholders, and send to any AI coding assistant.

## Files

| File | When to use |
|------|-------------|
| `new_feature.md` | Scaffold a complete feature (View + ViewModel + Service) |
| `new_view.md` | Create a SwiftUI View only |
| `new_viewmodel.md` | Create a ViewModel only |
| `new_service.md` | Create a Service layer only |
| `code_review.md` | Review existing code against project standards |
| `refactor.md` | Refactor code that violates standards |
| `unit_test.md` | Generate unit tests for a ViewModel or Service |

## Workflow

```
New feature end-to-end:
  new_feature.md  →  AI generates View + ViewModel + Service

Iterating on existing code:
  code_review.md  →  find violations
  refactor.md     →  fix violations

Adding tests:
  unit_test.md    →  generate tests for ViewModel or Service
```
