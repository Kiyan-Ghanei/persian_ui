# PersianUI

**A reusable Flutter UI component library with a focus on Persian and RTL-friendly interfaces.**

PersianUI is a Flutter package designed to help developers build interfaces using reusable components, shared design tokens, and theme utilities.

The project includes a public component API and an example application for exploring the available widgets.

> **Project status:** Under active development. API stability, RTL behavior, accessibility, and production readiness should be evaluated as the library evolves.

## Features

PersianUI currently provides components and utilities in the following areas:

- **Foundation:** Colors, spacing, border radius, and typography tokens.
- **Theming:** Theme utilities for consistent component styling.
- **Layout:** Containers, sections, rows, columns, grids, wrapping, and spacing.
- **Buttons:** Standard buttons, icon buttons, and loading buttons.
- **Cards:** General, informational, action, and status cards.
- **Display:** Avatars, badges, chips, dividers, expandable content, key-value pairs, list tiles, and statistics.
- **Inputs:** Text, password, number, and search fields.
- **Forms:** Checkboxes, radio controls, switches, dropdowns, date pickers, and sliders.
- **Feedback:** Dialogs, empty and error states, progress indicators, snackbars, and toasts.
- **Navigation:** Bottom navigation, breadcrumbs, navigation rails, and tabs.

The public API is exported through a single library entry point:

```dart
import 'package:persian_ui/persian_ui.dart';
```

## Requirements

- Flutter SDK
- Dart SDK compatible with the constraints in `pubspec.yaml`

## Getting started

### Use the local package

If you have cloned this repository, you can use the package locally by adding it as a path dependency to another Flutter project.

For example, if your application is located next to the `persian_ui` directory:

```yaml
dependencies:
  flutter:
    sdk: flutter
  persian_ui:
    path: ../persian_ui
```

Adjust the path to match your project structure.

Then run:

```bash
flutter pub get
```

### Run the example application

From the repository root:

```bash
cd example
flutter pub get
flutter run
```

Choose a device supported by your Flutter installation. For example, to run the application in Chrome:

```bash
flutter run -d chrome
```

The example application provides a visual showcase of selected PersianUI components.

## Usage

### Create a button

```dart
import 'package:flutter/material.dart';
import 'package:persian_ui/persian_ui.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PButton(
          text: 'Primary action',
          onPressed: () {
            debugPrint('Primary button pressed');
          },
        ),
        const SizedBox(height: 12),
        PButton(
          text: 'Secondary action',
          variant: PButtonVariant.secondary,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        PButton(
          text: 'Delete',
          variant: PButtonVariant.danger,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        PButton(
          text: 'Full-width button',
          fullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        const PButton(
          text: 'Disabled button',
          onPressed: null,
        ),
      ],
    );
  }
}
```

`PButton` supports three variants:

- `PButtonVariant.primary`
- `PButtonVariant.secondary`
- `PButtonVariant.danger`

It also supports three sizes: `PButtonSize.small`, `PButtonSize.medium`, and `PButtonSize.large`.

Set `fullWidth: true` to expand the button to the available width. Passing `null` to `onPressed` disables the button.

## Development

Run the following commands from the repository root to check the package:

### Analyze the package

```bash
flutter analyze
```

### Run package tests

```bash
flutter test
```

### Analyze and test the example application

```bash
cd example
flutter analyze
flutter test
```

Run these checks after making changes to help identify analysis issues and regressions.

## Project structure

```text
persian_ui/
├── lib/
│   ├── persian_ui.dart
│   └── src/
├── test/
├── example/
├── pubspec.yaml
├── analysis_options.yaml
├── CHANGELOG.md
├── LICENSE
└── README.md
```

- `lib/persian_ui.dart` exports the public API.
- `lib/src/` contains the component implementations.
- `test/` contains package tests.
- `example/` contains the example Flutter application.

## Roadmap

Potential future improvements include:

- Expanding component examples and documentation.
- Improving automated test coverage.
- Adding accessibility and responsive-layout checks.
- Validating Persian text rendering and right-to-left behavior across components.
- Preparing a stable release when the API and documentation are ready.

These are development goals, not claims that every item is already complete.

## Contributing

Contributions, bug reports, and suggestions are welcome. Before submitting a change, run the relevant analysis and tests, and include tests for new behavior where appropriate.

## License

See the `LICENSE` file for the project's license terms.