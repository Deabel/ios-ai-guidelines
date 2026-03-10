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
