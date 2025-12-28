# News App

A Flutter application for browsing news articles, built with a focus on clean architecture and modern design patterns.

## Features

- **Browse News**: View latest news articles organized by categories.
- **Article Details**: Read full details of news articles with images.
- **Bookmarks**: Save articles to read later (locally persisted).
- **Search**: Find articles by keywords.
- **Share**: Share interesting articles with others.
- **Dark/Light Mode**: (If applicable, based on standard features).

## Architecture

This project follows a **Feature-First** architecture with **Clean Architecture** principles, ensuring scalability and maintainability.

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) is used for managing application state.
- **Network**: [dio](https://pub.dev/packages/dio) and [http](https://pub.dev/packages/http) are used for API calls.
- **Code Generation**: [freezed](https://pub.dev/packages/freezed) is used for immutable data classes and unions.
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences) for persisting simple data (like bookmarks).

### Directory Structure

```
lib/
├── app/          # App configuration, themes, routes
├── core/         # Core utilities, constants, shared widgets, network clients
└── features/     # Feature modules (e.g., news)
    └── news/
        ├── bloc/           # bloc files.
        ├── data/           # Repositories, data sources, models
        └── presentation/   # Screens, widgets
```

## Dependencies

Key packages used in this project:

- `flutter_bloc`: State management
- `dio`: HTTP client
- `cached_network_image`: Efficient image loading and caching
- `google_fonts`: Custom typography
- `share_plus`: Platform integration for sharing content
- `shared_preferences`: Local data persistence
- `freezed_annotation`: Code generation for data classes

## Setup & Run Instructions

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (Version 3.32.0)
- Java SDK (Version 24.0.1 2025-04-15)
- Android Studio / VS Code with Flutter extensions
- Android Emulator or Physical Device

### Steps to Run

1.  **Clone the repository** (if applicable) or navigate to the project root.

2.  **Install Dependencies**:
    Run the following command in the terminal to fetch all required packages:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation** (Optional but recommended if changing models):
    Since this project uses `freezed`, you might need to generate files if they are missing:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the Application**:
    Connect your device or start an emulator, then run:
    ```bash
    flutter run
    ```
