# Prompt: New Service

Use this prompt when you need a Service layer class for data access or networking.

---

## Prompt Template

```
Create a Service called "[DomainName]Service" with the following requirements:

**Context:**
- Domain: [what domain this service covers, e.g. blood pressure, weight, user profile]
- Data source: [local GRDB/SQLite / REST API / Bluetooth / other]
- Operations needed: [list CRUD or other operations, e.g. fetchAll, fetchById, save, delete]
- Model types involved: [list the data models, e.g. BloodPressureRecord]

**Rules:**
- All async operations use async/await; no Combine
- No UI logic; no @Published properties
- No direct ViewModel dependencies
- Define a protocol for the service to support testability
- Accept dependencies (e.g. DatabaseQueue, NetworkClient) via initializer
- Function names start with verbs: fetch, save, update, delete
- Throw meaningful errors; do not swallow exceptions silently
```

---

## Example

```
Create a Service called "BloodPressureService" with the following requirements:

**Context:**
- Domain: Blood pressure measurements
- Data source: Local SQLite via GRDB
- Operations: fetchAll() -> [BloodPressureRecord], save(_ record: BloodPressureRecord), delete(id: Int64)
- Model types: BloodPressureRecord
```
