# PersianUI Example

This application showcases the reusable Flutter UI components provided by the PersianUI package.

## Purpose

The example application helps developers explore component appearance, behavior, and usage in a running Flutter application.

## Included Components

The showcase can be used to explore components from the following categories:

- Buttons
- Cards
- Display widgets
- Input fields
- Form controls
- Feedback widgets
- Layout helpers
- Navigation components
- Theme and design tokens

## Requirements

- Flutter SDK compatible with the root package requirements
- Dart SDK compatible with the project's `pubspec.yaml`

## Run the Example

From the repository root, run:

```bash
cd example
flutter pub get
flutter run
```

To run the example in Chrome, if Chrome is available as a Flutter device:

```bash
flutter run -d chrome
```

## Analyze and Test

Run static analysis:

```bash
flutter analyze
```

Run the example application's tests:

```bash
flutter test
```

## Package Dependency

This application uses the PersianUI package from the parent directory through a local path dependency.

```yaml
persian_ui:
  path: ../
```

The example application is intended for development and demonstration of PersianUI components.
