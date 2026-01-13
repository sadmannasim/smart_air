# Contributing to Smart Air

First off, thank you for considering contributing to Smart Air! 🎉

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and what you expected**
- **Include screenshots if relevant**
- **Specify Flutter and Dart versions**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List any similar features in other apps**

### Pull Requests

1. Fork the repo and create your branch from `main`
2. If you've added code that should be tested, add tests
3. Ensure the test suite passes
4. Make sure your code follows the existing code style
5. Write a good commit message

## Development Setup

1. Install Flutter SDK (>=3.0.0)
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/smart_air.git`
3. Install dependencies: `flutter pub get`
4. Set up Firebase (see README.md)
5. Run the app: `flutter run`

## Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter format` to format your code
- Run `flutter analyze` to check for issues
- Write clear, descriptive commit messages

## Code Structure

```
lib/
├── config/      # App configuration
├── models/      # Data models
├── services/    # Business logic and API calls
├── providers/   # State management
├── screens/     # UI screens
├── widgets/     # Reusable widgets
└── utils/       # Helper functions
```

## Commit Message Guidelines

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters
- Reference issues and pull requests after the first line

Examples:
```
Add passenger details validation

Fix issue with booking confirmation screen
Closes #123

Update README with setup instructions
```

## Testing

- Write unit tests for business logic
- Write widget tests for UI components
- Run tests: `flutter test`

## Documentation

- Update README.md if you change functionality
- Add inline comments for complex code
- Update API documentation if you change service methods

## Questions?

Feel free to create an issue with your question or reach out to the maintainers.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
