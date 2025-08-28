# Set New Password Feature

This feature allows users to set a new password with proper validation and follows clean architecture principles.

## Architecture

### Domain Layer
- `SetNewPasswordEntity`: Data model for password reset
- `SetNewPasswordRepository`: Abstract repository interface
- `SetNewPasswordUseCase`: Business logic for password reset

### Data Layer
- `SetNewPasswordRepositoryImpl`: Concrete implementation of the repository

### Presentation Layer
- `SetNewPasswordCubit`: State management using BLoC pattern
- `SetNewPasswordPage`: Main page with responsive design
- `SetNewPasswordForm`: Form widget with validation

## Features

- ✅ Responsive design for mobile and tablet
- ✅ Light/Dark theme support
- ✅ Password validation (length, case, numbers)
- ✅ Password confirmation matching
- ✅ Form validation with error messages
- ✅ Loading states and error handling
- ✅ Keyboard-aware scrolling
- ✅ Clean architecture principles
- ✅ Under 100 lines per file

## Usage

### Navigation
```dart
Navigator.of(context).pushNamed(Routes.setNewPasswordScreen);
```

### Password Requirements
- Minimum 8 characters
- At least one lowercase letter
- At least one uppercase letter
- At least one number

## Dependencies
- flutter_bloc for state management
- equatable for value equality
- easy_localization for internationalization
- All other dependencies are from the existing project
