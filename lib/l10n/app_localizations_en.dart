// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Base App';

  @override
  String get loginTitle => 'Welcome back';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Sign In';

  @override
  String get logoutButton => 'Sign Out';

  @override
  String get errorInvalidEmail => 'Please enter a valid email';

  @override
  String get errorEmptyPassword => 'Password cannot be empty';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorUnauthorized => 'Invalid credentials';

  @override
  String get errorNoInternet => 'No internet connection';

  @override
  String get homeTitle => 'Home';
}
