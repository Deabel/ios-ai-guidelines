# Architecture

Architecture pattern:

MVVM + Service Layer

Layer order:

View ViewModel Service Network

Rules:

Views must be written using SwiftUI unless explicitly required to use UIKit.

Views must not contain business logic.

ViewModels manage state and business logic.

Networking must exist only in Service layer.

Views communicate only with ViewModels.

Example flow:

View -\> ViewModel -\> Service -\> Network
