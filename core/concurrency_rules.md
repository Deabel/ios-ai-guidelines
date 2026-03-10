# Concurrency Rules

Preferred concurrency model:

Swift Structured Concurrency

Rules:

Use async/await for networking.

UI updates must occur on MainActor.

Avoid Task.detached unless necessary.

Use TaskGroup for parallel work.

Avoid callback-based APIs.
