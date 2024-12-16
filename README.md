# zxplore_gh

A Cross Platform Mobile app for Account Creation By Zenith Staff for Zenith Ghana

## Project Structure

```
lib/
├── apis/          # API integrations and network calls
├── blocs/         # Business Logic Components/BLoC state management
├── constants/     # Application-wide constants and configurations
├── data/         # Data layer (repositories implementations, data sources)
├── libs/         # Shared libraries and utilities
├── models/       # Data models and entities
├── navigation/   # Navigation/routing related code
├── repositories/ # Repository interfaces and implementations
└── screens/      # UI screens and widgets
    ├── controllers/    # Screen-specific controllers
    │   ├── edit_controllers/
    │   ├── epma_controllers/
    │   ├── home/
    │   ├── login/
    │   ├── meta/
    │   └── pending_requests/
    └── forms/          # Form-related screens
        └── epma/       # EPMA specific forms
```

## Getting Started

### Prerequisites
- Flutter SDK (Latest stable version)
- Android Studio / VS Code
- iOS development setup (for iOS deployment)

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Features

- User Authentication (Login)
- Home Dashboard
- Location Tracking
- EPMA (Electronic Prescribing and Medicines Administration)
- Form Management
- Pending Requests Handler
- Meta Information Display

## Architecture

This project follows a clean architecture approach with:
- Riverpod/ BLoC Pattern for state management
- Repository Pattern for data handling
- Controller-based screen management
- Organized feature modules

## Code Style

- Follow official Dart style guide
- Use meaningful naming conventions
- Implement proper documentation for public APIs
- Maintain consistent file naming:
  - snake_case for files
  - camelCase for variables and methods
  - PascalCase for classes

## Assets

All project assets are stored in the `assets/` directory and should be declared in `pubspec.yaml`.

## Development Guidelines

1. Create new features in dedicated feature branches
2. Follow BLoC pattern for state management
3. Implement proper error handling
4. Write unit tests for business logic
5. Document complex implementations
6. Use constants for repeated values

## Testing

Run tests using:
```bash
flutter test
```

## Build

Generate release build:

For Android:
```bash
flutter build apk --release
```

For iOS:
```bash
flutter build ios --release
```

## Dependencies

Key packages used in this project:
- flutter_bloc: State management
- dio: Network calls
- shared_preferences: Local storage
- riverpod: Dependency injection

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

