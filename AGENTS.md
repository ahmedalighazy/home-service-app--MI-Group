# AGENTS.md — Home Service App

A Flutter home-services marketplace (cleaning, etc.) with Arabic-first RTL UI.

## Tech Stack

`flutter` + `dart` (SDK ^3.11.3) · `go_router` · `flutter_bloc` (Cubits only, no events) · `get_it` · `retrofit` + `dio` · `easy_localization` (ar/en) · `flutter_screenutil` · `json_annotation` (codegen only for `ApiErrorModel`).

## Dev Commands

| Command | Purpose |
|---|---|
| `flutter pub get` | Install deps |
| `flutter pub run build_runner build --delete-conflicting-outputs` | Regenerate Retrofit `.g.dart` |
| `flutter analyze` | Lint + static analysis |
| `flutter test` | Run tests (only 1 smoke test exists) |

## Architecture

**Feature-first** — each feature under `lib/features/{name}/` with a `data/` and `presentation/` sub-tree. The main authenticated shell is `lib/core/shell/main_shell.dart` (3-tab bottom nav: Home, Booking, Profile).

**Data flow:** UI → Cubit (emit Loading) → Repo → ApiService (Retrofit) → Dio → server. Repos catch errors with `ErrorHandler.handle(e)` and return `ApiResult<T>`. Cubits call `response.when(success:, failure:)` — never manual type checks.

**Models:** Manual `fromJson`/`toJson` (no freezed). Only `ApiErrorModel` uses `@JsonSerializable`.

**DI:** Register in `lib/core/di/injection.dart` → `setupGetIt()`. Pattern: Repo as `registerLazySingleton`, Cubit as `registerLazySingleton` (or `registerFactory` if ephemeral). Access via `getIt<Type>()`.

## Routing

`GoRouter` in `lib/core/routes/app_routes.dart`. All route path constants in `AppRouter`. An auth `redirect` guards `/home` by checking `CacheHelper.getData(key: 'token')`.

**Navigation:** Use `context.go('/path')` or `context.pushNamed(...)` when using named routes from `AppRouter`.

## Network

- Base URL: `https://cleaningapi.twintech-it.com` (`ApiConstants.baseUrl`)
- Dio configured in `DioClient` (10s timeout, `ApiInterceptor` for JSON header + logging)
- Add new endpoints to `ApiConstants`, add method to `ApiService` abstract, then run `build_runner`
- API response wrapper: `ApiResult<T>` (sealed class) — always use `.when()` in Cubits

## Localization

`easy_localization` with JSON files in `assets/translations/` (en.json, ar.json). Fallback: `ar`. The `LanguageCubit` (not `AppCubit`) manages locale state, persisted via `CacheHelper`. `AppStrings` in `lib/core/utils/l10n/app_strings.dart` provides static translation getters.

## Key Conventions

- **CacheHelper** is fully static (`CacheHelper.getData`, `CacheHelper.saveData`) — no need for `getIt` to access it
- **State naming:** prefer `sealed class` + `final class` for new Cubit states
- **Colors:** `AppColors` in `lib/core/themes/colors/app_colors.dart` (teal `#189AB4`, yellow `#FEBB38`, black) — never hardcode
- **Text styles:** `Theme.of(context).textTheme` or `GoogleFonts` — avoid inline `TextStyle`
- **RTL:** `Directionality` widget in `main.dart` handles RTL based on locale; use `LocaleKeys` or `AppStrings` for text, never raw strings
- **ScreenUtil:** `ScreenUtilInit` wraps the app; use `ScreenUtil().setWidth()` etc. for responsive sizing

## Important Notes

- **`PROJECT_RULES.md` is outdated** — it describes a prior architecture (custom `onGenerateRoute`, `AppCubit`, `lib/core/get_it/`, etc.). Trust the actual source files, not that doc.
- **`FINAL_SUMMARY.txt`, `GUIDE_SUMMARY.txt`, and `LANGUAGE_SUMMARY.txt`** are session-generated docs from prior AI sessions — not authoritative. Use actual source as source of truth.
- **No CI/CD** config found. No Docker. No pre-commit hooks.
- **Single smoke test** in `test/widget_test.dart` — real test infrastructure is not set up.
