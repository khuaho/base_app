# Base App

Flutter base app — production-ready boilerplate.

## Stack

| Layer | Package | Version |
|---|---|---|
| Flutter | FVM | 3.35.7 |
| Dart SDK | — | ≥3.9.2 |
| State management | `flutter_bloc` + `freezed` | ^9.1.1 / ^3.2.5 |
| Routing | `auto_route` | ^11.1.0 |
| DI | `get_it` + `injectable` | ^9.2.1 / ^3.0.0 |
| Network | `dio` + `retrofit` | ^5.9.2 / ^4.9.2 |
| Storage | `flutter_secure_storage` + `shared_preferences` | ^10.1.0 / ^2.5.5 |
| Localization | `flutter_localizations` + `intl` | ^0.20.2 |
| Flavor | `flutter_flavorizr` | ^2.4.2 |

## Architecture

```
lib/
├── flavors.dart             # Flavor enum + class F (baseUrl, title, enableLogging)
├── main.dart                # Entry point duy nhất — đọc flavor từ --dart-define
├── bootstrap.dart           # Setup DI + runApp
├── app.dart                 # MaterialApp.router + BlocProvider
│
├── core/
│   ├── constants/           # AppConstants (timeouts, storage keys, pagination)
│   ├── di/                  # get_it + injectable setup
│   │   └── modules/         # NetworkModule, StorageModule
│   ├── env/                 # Re-export flavors.dart
│   ├── error/               # Exceptions & Failures
│   ├── network/             # DioFactory + interceptors (Auth, Log)
│   ├── router/              # AppRouter (auto_route) + AuthGuard
│   ├── storage/             # SecureStorage + LocalStorage
│   ├── theme/               # AppTheme (light/dark), AppColors, AppTextStyles
│   └── utils/               # BuildContext extensions (l10n, theme, screen size)
│
├── features/
│   └── auth/
│       ├── data/            # UserModel, AuthRemoteDataSource (Retrofit), AuthRepositoryImpl
│       ├── domain/          # UserEntity, AuthRepository interface, UseCases
│       └── presentation/
│           ├── cubit/       # AuthCubit + AuthState (Freezed single-class)
│           ├── pages/       # SplashPage, LoginPage
│           └── widgets/     # LoginForm
│
├── features/home/
│   └── presentation/pages/  # HomePage
│
├── shared/
│   ├── extensions/          # StringExtensions
│   └── widgets/             # AppButton, AppTextField, LoadingOverlay
│
└── l10n/                    # app_en.arb, app_vi.arb
```

## Flavor setup

Flavors được quản lý bởi `flutter_flavorizr`. Config tại `flavorizr.yaml`.

| Flavor | App name | Bundle / App ID | Firebase |
|---|---|---|---|
| `dev` | Base app Dev | `com.base.app.dev` / `com.vtn.global.base.flutter` | `.firebase/dev/` |
| `prod` | Base app | `com.base.app` / `com.vtn.example.prod` | `.firebase/prod/` |

> Thay `baseUrl` thật trong `lib/flavors.dart` và Firebase config thật trong `android/app/src/<flavor>/google-services.json` + `ios/Runner/<flavor>/GoogleService-Info.plist`.

## Getting started

### 1. Cài FVM & Flutter

```bash
dart pub global activate fvm
fvm install 3.35.7
fvm use 3.35.7
```

### 2. Cài dependencies

```bash
fvm flutter pub get
```

### 3. Chạy code generation

```bash
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

> Nếu lỗi cache: `rm -rf .dart_tool && fvm flutter pub get` rồi chạy lại.

### 4. Chạy app theo flavor

```bash
# Dev
fvm flutter run --flavor dev --dart-define=FLUTTER_APP_FLAVOR=dev

# Production
fvm flutter run --flavor prod --dart-define=FLUTTER_APP_FLAVOR=prod
```

### 5. Build

```bash
# Android APK
fvm flutter build apk --flavor prod --dart-define=FLUTTER_APP_FLAVOR=prod

# iOS
fvm flutter build ipa --flavor prod --dart-define=FLUTTER_APP_FLAVOR=prod
```

### 6. Run tests

```bash
fvm flutter test
```

## State management pattern

Dùng **Cubit** + **Freezed** (single-class state với fields):

```dart
// State — một class, nhiều fields
@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    UserEntity? user,
    String? error,
    @Default(false) bool isUnauthenticated,
  }) = _AuthState;
}

// Cubit — methods thay vì events
class AuthCubit extends Cubit<AuthState> {
  Future<void> login({required String email, required String password}) async {
    emit(const AuthState(isLoading: true));
    // ...
    emit(AuthState(user: user));
  }
}

// UI
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) {
    if (state.isLoading) return const CircularProgressIndicator();
    if (state.error != null) return Text(state.error!);
    return Text('Hello, ${state.user?.name}');
  },
)
```

## Adding a new feature

1. Tạo `lib/features/<name>/` với `data/`, `domain/`, `presentation/`
2. Định nghĩa entity + repository interface trong `domain/`
3. Implement data layer trong `data/` (model với `@JsonSerializable`, datasource với `@RestApi`)
4. Đăng ký DI với `@injectable` / `@LazySingleton(as: Repository)`
5. Tạo Cubit + Freezed state trong `presentation/cubit/`
6. Thêm route trong `lib/core/router/app_router.dart`
7. Chạy lại `build_runner`

## Known issues

| Issue | Nguyên nhân | Fix |
|---|---|---|
| `bloc_test` conflict | Flutter 3.35.7 pin `test_api 0.7.6`, incompatible với `bloc_test ^10.x` + `build_runner ^2.15.x` | Upgrade Flutter lên version có Dart ≥3.10.0 |
