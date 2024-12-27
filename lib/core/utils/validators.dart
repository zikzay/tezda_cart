class Validator {
  static bool isValidEmail(String? email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email ?? '');
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static String? notEmpty(String? value, String? name) {
    if (value == null || value.isEmpty) {
      return '${name ?? 'This field'} is required';
    }

    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email address is required';
    }

    if (!isValidEmail(email)) {
      return 'Invalid email';
    }

    return null;
  }
}
