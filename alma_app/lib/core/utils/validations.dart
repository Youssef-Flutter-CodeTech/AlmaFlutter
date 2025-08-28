class Validations {
  static bool isEmailValid(String email) {
    return RegExp(r'^[^@]+@[^@]+.[^@]+').hasMatch(email);
  }

  static bool hasLowerCase(String password) {
    return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password);
  }

  static String maskEmail(String email) {
    if (!email.contains('@') || email.isEmpty) {
      return email;
    }

    final parts = email.split('@');
    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 1) {
      return '$username@$domain';
    }

    final maskedUsername = '${username[0]}${'*' * (username.length - 1)}';

    return '$maskedUsername@$domain';
  }
}
