# Flutter Project Guide

## Commands
- **Build/Run**: `flutter run` (debug), `flutter build` (release)
- **Dependencies**: `flutter pub get`, `flutter pub upgrade`
- **Code Generation**: `flutter pub run build_runner build --delete-conflicting-outputs`
- **Testing**: `flutter test [path_to_test]` (for a single test)
- **Linting**: `flutter analyze`, `flutter format .`

## Code Style
- **Files**: Use snake_case naming (e.g., `auth_repository.dart`)
- **Classes**: Use PascalCase (e.g., `ApiClient`, `AuthRepository`)
- **Variables**: Use camelCase (e.g., `apiService`, `userData`)
- **Imports**: Dart/Flutter imports first, then packages, then project imports
- **BLoC Pattern**: Follow feature_bloc/event/state separation
- **Models**: Use freezed for immutable models with code generation
- **Error Handling**: Use Try/catch with centralized error handling in repositories
- **Repository Pattern**: Abstract class + implementation class
- **DI**: Use GetIt for dependency injection
- **State Management**: BLoC pattern with Cubit for simpler use cases