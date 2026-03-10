# Prompt: New SwiftUI View

Use this prompt when you only need a new View (ViewModel already exists or is not needed).

---

## Prompt Template

```
Create a SwiftUI View called "[ViewName]View" with the following requirements:

**Context:**
- Purpose: [what this view displays or allows the user to do]
- ViewModel type: [ViewModelName] (injected via @ObservedObject / owned via @StateObject)
- Navigation: [describe any navigation actions, e.g. push to detail, present sheet]
- UI components needed: [list the main UI elements]

**Rules:**
- SwiftUI only; no UIKit unless explicitly required
- Max ~150 lines; extract subviews if needed
- No business logic inside the view
- Use @StateObject only if this view owns the ViewModel
- Use @ObservedObject if the ViewModel is injected from outside
- Local UI state (e.g. isShowingSheet) uses @State
- Call ViewModel async methods inside Task { } blocks
```

---

## Example

```
Create a SwiftUI View called "WeightHistoryView" with the following requirements:

**Context:**
- Purpose: Show a scrollable list of weight records grouped by month
- ViewModel type: WeightHistoryViewModel (injected via @ObservedObject)
- Navigation: Tapping a row pushes WeightDetailView
- UI components: List, section headers by month, row with date + weight value + unit label

**Rules:**
[same as above]
```
