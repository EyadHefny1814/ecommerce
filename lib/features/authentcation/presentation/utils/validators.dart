/// Reusable validators for the auth feature's form fields.
/// Keeping these in one place avoids duplicating regex/logic
/// across every screen that needs a name, email, phone, or password.
class Validators {
  Validators._();

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 2) {
      return 'Name is too short';
    }
    return null;
  }

  static final RegExp _emailRegex =
      RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static final RegExp _phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    if (!_phoneRegex.hasMatch(value.trim().replaceAll(' ', ''))) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  /// Pass the original password so it can be compared against.
  static String? Function(String?) confirmPassword(String password) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }
      if (value != password) {
        return 'Passwords do not match';
      }
      return null;
    };
  }
}
