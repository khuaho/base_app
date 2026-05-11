// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'Base App';

  @override
  String get loginTitle => 'Chào mừng trở lại';

  @override
  String get loginSubtitle => 'Đăng nhập để tiếp tục';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Mật khẩu';

  @override
  String get loginButton => 'Đăng nhập';

  @override
  String get logoutButton => 'Đăng xuất';

  @override
  String get errorInvalidEmail => 'Vui lòng nhập email hợp lệ';

  @override
  String get errorEmptyPassword => 'Mật khẩu không được để trống';

  @override
  String get errorGeneric => 'Đã xảy ra lỗi. Vui lòng thử lại.';

  @override
  String get errorUnauthorized => 'Thông tin đăng nhập không đúng';

  @override
  String get errorNoInternet => 'Không có kết nối internet';

  @override
  String get homeTitle => 'Trang chủ';
}
