# Auth Feature - Clean Architecture Complete Overview

## Project Structure

```
lib/features/auth/
├── domain/                              # 🔒 PURE BUSINESS LOGIC
│   ├── entities/
│   │   ├── user_entity.dart
│   │   └── auth_token_entity.dart
│   ├── repositories/
│   │   └── auth_repository.dart         # Abstract interface
│   └── usecases/                        # Business logic (no Flutter deps)
│       ├── sign_in_usecase.dart
│       ├── sign_up_usecase.dart
│       ├── verify_otp_usecase.dart
│       ├── complete_profile_usecase.dart
│       ├── password_reset_usecase.dart
│       └── social_sign_in_usecase.dart
│
├── data/                                # 🔌 API & LOCAL STORAGE
│   ├── datasources/
│   │   ├── auth_local_datasource.dart   # Abstract interface
│   │   ├── auth_local_datasource_impl.dart
│   │   ├── auth_remote_datasource.dart  # Abstract interface
│   │   └── auth_remote_datasource_impl.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── auth_token_model.dart
│   │   ├── sign_in_request_model.dart
│   │   └── otp_request_model.dart
│   ├── repositories/
│   │   └── auth_repository_impl.dart
│   └── exceptions/
│       └── exceptions.dart
│
├── presentation/                        # 👁️ USER INTERFACE
│   ├── screens/
│   │   ├── sign_in_screen/
│   │   │   └── sign_in_screen.dart
│   │   ├── sign_up_screen/
│   │   │   └── sign_up_screen.dart
│   │   ├── otp_screen/
│   │   │   └── otp_screen.dart
│   │   ├── complete_profile_screen/
│   │   │   └── complete_profile_screen.dart
│   │   ├── forgot_password_screen/
│   │   │   └── forgot_password_screen.dart
│   │   ├── verify_reset_code_screen/
│   │   │   └── verify_reset_code_screen.dart
│   │   ├── set_new_password_screen/
│   │   │   └── set_new_password_screen.dart
│   │   └── password_changed_successfully_screen/
│   │       └── password_changed_successfully_screen.dart
│   ├── widgets/
│   │   ├── auth_text_field_widget.dart
│   │   └── auth_button_widget.dart
│   ├── cubits/
│   │   ├── auth_cubit.dart              # ❌ DEPRECATED (calls Repository)
│   │   └── auth_cubit_v2.dart           # ✅ CURRENT (calls UseCases)
│   ├── states/
│   │   └── auth_state.dart
│   └── providers/
│       └── auth_providers.dart
│
├── logic/                               # 🧠 HELPER LOGIC (NO UI)
│   ├── validators/
│   │   ├── sign_in_validator.dart       # Pure Dart functions
│   │   ├── sign_up_validator.dart
│   │   ├── otp_validator.dart
│   │   └── profile_validator.dart
│   └── services/
│       └── otp_timer_service.dart       # No Flutter UI deps
│
└── utils/
    └── auth_strings.dart                # All UI text (centralized)
```

---

## Layer Responsibilities

### 1️⃣ Domain Layer (Pure Dart)

**What**: Pure business logic, no external dependencies
**Why**: Testable, framework-agnostic, reusable
**Who**: Business rules and use cases

**Files**:
- `entities/` - Business models (User, AuthToken)
- `repositories/` - Abstract interfaces for data access
- `usecases/` - Business logic (authentication, validation)

**Example UseCase**:
```dart
class SignInUseCase {
  final AuthRepository repository;
  
  Future<Either<Failure, AuthTokenEntity>> call({
    required String email,
    required String password,
  }) async {
    // Business logic: validate input, call repository
    if (email.isEmpty || password.isEmpty) {
      return Left(ValidationFailure('Required fields'));
    }
    return repository.signIn(email, password);
  }
}
```

**Key Points**:
✅ No Flutter imports
✅ No database imports
✅ No API client imports
✅ Pure Dart functions
✅ Returns Either<Failure, Success>

---

### 2️⃣ Data Layer (Implementation)

**What**: External data sources (API, local storage, models)
**Why**: Separate data access from business logic
**Who**: Data repository implementation

**Files**:
- `models/` - API response/request DTOs with mappers
- `datasources/` - Local and remote data access (abstract + impl)
- `repositories/` - Repository implementation (uses datasources)
- `exceptions/` - Custom exceptions

**Architecture**:
```
Repository (interface)
    ↓
RepositoryImpl (coordinate datasources)
    ├── LocalDataSource (SharedPreferences)
    └── RemoteDataSource (HTTP API)
```

**Example Model with Mapper**:
```dart
class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String email,
    String? name,
  }) : super(id: id, email: email, name: name);

  // JSON to Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }

  // Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  // Entity to Model (from domain)
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
    );
  }

  // Model to Entity (to domain)
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
    );
  }
}
```

**Key Points**:
✅ Concrete implementations of abstract repositories
✅ Models with JSON serialization
✅ DataSource coordination
✅ Error handling and transformation

---

### 3️⃣ Presentation Layer (UI)

**What**: User interface, state management, widgets
**Why**: Separate UI from business logic
**Who**: Screens, widgets, Cubit

**Files**:
- `screens/` - Full screen widgets (8 screens)
- `widgets/` - Reusable UI components
- `cubits/` - State management (calls UseCases)
- `states/` - State definitions (sealed class)

**Architecture**:
```
Screen (UI)
    ↓
BlocListener/BlocBuilder
    ↓
Cubit (state management)
    ↓
UseCase (business logic)
```

**Example Screen Pattern**:
```dart
class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubitV2>();
  }

  void _handleSignIn() {
    // 1. Validate using validator (no Cubit needed)
    final error = SignInValidator.validateEmail(_emailCtrl.text);
    if (error != null) {
      _showError(error);
      return;
    }

    // 2. Call Cubit (which calls UseCase)
    _authCubit.signIn(
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubitV2, AuthState>(
        listener: (context, state) {
          if (state is SignInSuccessState) {
            // Navigate to home
          } else if (state is SignInErrorState) {
            _showError(state.message);
          }
        },
        child: BlocBuilder<AuthCubitV2, AuthState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildEmailField(),
                _buildPasswordField(),
                _buildSignInButton(),
              ],
            );
          },
        ),
      ),
    );
  }
}
```

**Key Points**:
✅ Screen delegates to Cubit, never Repository
✅ Validator used for synchronous validation
✅ BlocListener for side effects (navigation, snackbars)
✅ BlocBuilder for UI updates based on state
✅ Proper disposal of resources

---

### 4️⃣ Logic Layer (Helper)

**What**: Non-UI business logic (validators, services)
**Why**: Reusable, testable, no UI dependencies
**Who**: Validators and utility services

**Validators**:
```dart
class SignInValidator {
  // Pure functions, no UI dependencies
  static String? validateEmail(String email) {
    if (email.isEmpty) return 'Email required';
    if (!email.contains('@')) return 'Invalid email';
    return null;
  }

  static bool isFormValid({
    required String email,
    required String password,
  }) {
    return validateEmail(email) == null &&
        validatePassword(password) == null;
  }
}
```

**Services**:
```dart
class OtpTimerService {
  // No Flutter UI dependencies
  Timer? _timer;
  int _remainingSeconds = 60;
  
  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _remainingSeconds--;
      _onTick(_remainingSeconds);
      
      if (_remainingSeconds == 0) {
        _onExpired();
        _timer?.cancel();
      }
    });
  }
  
  void dispose() {
    _timer?.cancel();
  }
}
```

**Key Points**:
✅ No Flutter imports
✅ No external dependencies
✅ Pure Dart logic
✅ Callback-based communication
✅ Fully testable

---

## Data Flow

### Sign In Flow

```
1. User enters email/password
   ↓
2. Screen validates with SignInValidator (synchronous)
   ↓
3. Screen calls authCubit.signIn()
   ↓
4. Cubit emits AuthLoadingState
   ↓
5. Cubit calls SignInUseCase
   ↓
6. UseCase validates (business logic)
   ↓
7. UseCase calls repository.signIn()
   ↓
8. RepositoryImpl coordinates:
   - RemoteDataSource (API call)
   - LocalDataSource (save token)
   ↓
9. Success → Return AuthTokenEntity
   ↓
10. Cubit receives token → emits SignInSuccessState
    ↓
11. Screen listener → Shows success → Navigates to Home
```

### OTP Verification Flow

```
1. User enters 6-digit OTP
   ↓
2. Screen validates with OtpValidator (synchronous)
   ↓
3. Screen calls authCubit.verifyOtp()
   ↓
4. Cubit emits AuthLoadingState
   ↓
5. Cubit calls VerifyOtpUseCase
   ↓
6. UseCase validates (business logic)
   ↓
7. UseCase calls repository.verifyOtp()
   ↓
8. RepositoryImpl:
   - RemoteDataSource (verify with API)
   - LocalDataSource (save verification)
   ↓
9. Success → Return confirmation
   ↓
10. Cubit emits OtpVerifiedState
    ↓
11. Screen listener → Shows success → Navigates to Complete Profile
```

---

## State Management (AuthCubitV2)

### Cubit Structure

```dart
class AuthCubitV2 extends Cubit<AuthState> {
  // All 9 UseCases injected
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  // ... other usecases

  // Each method calls the appropriate UseCase
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    
    final result = await _signInUseCase(
      email: email,
      password: password,
    );
    
    result.fold(
      (failure) => emit(SignInErrorState(failure.message)),
      (token) => emit(SignInSuccessState(...)),
    );
  }
}
```

### State Hierarchy

```
AuthState (sealed)
├── AuthInitialState
├── AuthLoadingState
├── AuthErrorState
├── SignInSuccessState
├── SignInErrorState
├── OtpSentState
├── OtpVerifiedState
├── OtpInvalidCodeState
├── OtpExpiredState
├── ProfileCompletedState
├── ProfileCompletionErrorState
├── ResetCodeSentState
├── ResetCodeVerifiedState
├── PasswordResetSuccessState
├── GoogleSignInSuccessState
└── AppleSignInSuccessState
```

---

## Separation of Concerns Checklist

### ✅ Domain Layer (100% Pure Dart)
- [x] No Flutter imports
- [x] No external packages except dartz (for Either)
- [x] Business logic only
- [x] Entities are plain Dart classes
- [x] Repositories are abstract interfaces
- [x] UseCases contain business rules

### ✅ Data Layer (Implementation Details)
- [x] Models with JSON mappers
- [x] DataSource interfaces (abstract)
- [x] DataSource implementations (Local + Remote)
- [x] Repository implementation coordinates datasources
- [x] Exception classes for error handling
- [x] No UI dependencies

### ✅ Presentation Layer (UI Only)
- [x] Screens only handle UI rendering
- [x] Screens delegate logic to Cubit
- [x] Cubit delegates to UseCase
- [x] Never direct Repository calls
- [x] Validators used for sync validation
- [x] Services for business logic (no UI)

### ✅ Logic Layer (Helpers)
- [x] Validators are pure functions
- [x] Services are utility classes
- [x] No UI dependencies
- [x] Fully testable
- [x] Callback-based communication

---

## Key Principles

### 1. Dependency Injection
```dart
// Constructor injection prevents tight coupling
class AuthCubitV2 extends Cubit<AuthState> {
  AuthCubitV2({
    required SignInUseCase signInUseCase,
    required SignUpUseCase signUpUseCase,
    // ...
  });
}

// Setup in main.dart
getIt.registerSingleton<AuthCubitV2>(
  AuthCubitV2(
    signInUseCase: getIt(),
    signUpUseCase: getIt(),
    // ...
  ),
);
```

### 2. Single Responsibility
- Validator: Only validates input
- Service: Only manages specific logic (timer)
- Screen: Only renders UI
- Cubit: Only manages state
- UseCase: Only contains business logic
- Repository: Only coordinates data sources
- DataSource: Only accesses specific data store

### 3. Open/Closed Principle
```dart
// Easy to extend without modifying
abstract class AuthRepository {
  Future<Either<Failure, AuthTokenEntity>> signIn(...);
}

// Multiple implementations possible
class AuthRepositoryImpl extends AuthRepository { ... }
class MockAuthRepository extends AuthRepository { ... }
```

### 4. Liskov Substitution
```dart
// Any DataSource implementation works
abstract class AuthRemoteDataSource {
  Future<UserModel> getUser(String id);
}

class AuthRemoteDataSourceReal extends AuthRemoteDataSource { ... }
class AuthRemoteDataSourceMock extends AuthRemoteDataSource { ... }
```

### 5. Interface Segregation
```dart
// Focused, specific interfaces
abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> signIn(...);
}

abstract class AuthLocalDataSource {
  Future<void> saveToken(AuthTokenModel token);
}
```

### 6. Dependency Inversion
```dart
// Depend on abstractions, not implementations
class RepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  
  RepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  });
}
```

---

## Testing Strategy

### Unit Tests (Domain + Logic)
```dart
// Pure functions, easy to test
test('Email validation rejects invalid email', () {
  expect(
    SignInValidator.validateEmail('invalid'),
    isNotNull,
  );
});

// UseCases with mock repository
test('SignInUseCase calls repository with correct params', () async {
  final mockRepo = MockAuthRepository();
  final useCase = SignInUseCase(mockRepo);
  
  await useCase(email: 'test@test.com', password: 'pass123');
  
  verify(mockRepo.signIn(...)).called(1);
});
```

### Widget Tests (Presentation)
```dart
// Test screen rendering and interactions
testWidgets('SignInScreen renders email field', (tester) async {
  await tester.pumpWidget(TestApp());
  
  expect(find.byType(TextField), findsWidgets);
});
```

### Integration Tests
```dart
// Test complete flows
testWidgets('Complete sign in flow', (tester) async {
  // Fill form
  // Tap button
  // Verify navigation
});
```

---

## Development Workflow

### Adding a New Feature

1. **Domain Layer** (Business Logic)
   - Create Entity
   - Create Repository interface
   - Create UseCase

2. **Data Layer** (Implementation)
   - Create Model with mappers
   - Create DataSource interfaces
   - Create DataSource implementations
   - Create Repository implementation

3. **Presentation Layer** (UI)
   - Create Screen
   - Create Cubit method (calls UseCase)
   - Create/Update State
   - Setup navigation

4. **Logic Layer** (Helpers)
   - Create Validator if needed
   - Create Service if needed

5. **Testing**
   - Unit tests for UseCase
   - Unit tests for Validator
   - Widget tests for Screen
   - Integration tests for flow

---

## Common Issues & Solutions

### Issue: Validation in Cubit
```dart
❌ BAD
class AuthCubit {
  void signIn(String email, String password) {
    if (email.isEmpty) return; // Validation in Cubit
  }
}

✅ GOOD
// Validation in Validator (before Cubit)
if (SignInValidator.validateEmail(email) != null) {
  _showError();
  return;
}
_authCubit.signIn(email, password);
```

### Issue: Business Logic in Screen
```dart
❌ BAD
class SignInScreen {
  void _handleSignIn() {
    // Complex business logic here
    if (token.isEmpty) { ... }
  }
}

✅ GOOD
class SignInScreen {
  void _handleSignIn() {
    // Just call Cubit
    _authCubit.signIn(email, password);
  }
}
```

### Issue: Direct Repository Calls in Screen
```dart
❌ BAD (DEPRECATED - see auth_cubit.dart)
class AuthCubIt {
  void signIn() async {
    final result = await _repository.signIn(); // ❌ Direct repo call
  }
}

✅ GOOD (CURRENT - see auth_cubit_v2.dart)
class AuthCubitV2 {
  void signIn() async {
    final result = await _signInUseCase(...); // ✅ UseCase call
  }
}
```

---

## Summary

```
┌───────────────────────────────────────────────────┐
│         CLEAN ARCHITECTURE IN ACTION              │
├───────────────────────────────────────────────────┤
│ 🔒 DOMAIN: Pure business logic                   │
│    - Entities, Repositories (interfaces)         │
│    - UseCases (independent of framework)         │
│                                                   │
│ 🔌 DATA: Implementation details                  │
│    - Models, DataSources                         │
│    - Repository implementation                   │
│                                                   │
│ 👁️ PRESENTATION: User interface                 │
│    - Screens (8 auth flows)                      │
│    - Cubit (calls UseCases)                      │
│    - States (sealed class)                       │
│                                                   │
│ 🧠 LOGIC: Helper utilities                       │
│    - Validators (pure functions)                 │
│    - Services (no UI deps)                       │
│                                                   │
│ 📝 STRINGS: Centralized text                     │
│    - No hardcoded strings                        │
│    - RTL-ready (Arabic)                          │
└───────────────────────────────────────────────────┘

✅ All layers strictly separated
✅ Testable at every level
✅ Easy to maintain and extend
✅ Framework-agnostic domain logic
✅ Reusable components
```
