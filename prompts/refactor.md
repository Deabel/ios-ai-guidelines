# Prompt: Refactor Existing Code

Use this prompt to ask AI to refactor code that violates project standards.

---

## Prompt Template

```
Refactor the following Swift code to comply with project standards.

**Known issues to fix (optional, fill in what you know):**
- [ ] Business logic inside View
- [ ] Networking inside ViewModel (should be in Service)
- [ ] Global singleton usage
- [ ] Callback-based async code (convert to async/await)
- [ ] Combine used for networking (replace with async/await)
- [ ] Naming violations
- [ ] ViewModel not annotated with @MainActor
- [ ] Other: [describe]

**Constraints:**
- Preserve existing public interfaces unless a rename is explicitly listed above
- Do not change unrelated logic
- Add a comment // REFACTORED: [reason] above each changed block

**Output format:**
Show the complete refactored file(s). Do not show only diffs.

**Code to refactor:**
[paste your code here]
```
