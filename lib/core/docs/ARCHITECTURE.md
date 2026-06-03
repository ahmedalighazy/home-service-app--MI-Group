# Architecture Documentation

## Overview

This project follows **Clean Architecture** principles with a **feature-first** organization structure. The architecture ensures separation of concerns, testability, maintainability, and scalability.

## Table of Contents

1. [Architecture Layers](#architecture-layers)
2. [Project Structure](#project-structure)
3. [Dependency Rule](#dependency-rule)
4. [Data Flow](#data-flow)
5. [State Management](#state-management)
6. [Dependency Injection](#dependency-injection)
7. [Error Handling](#error-handling)
8. [Testing Strategy](#testing-strategy)
9. [Advanced Topics](#advanced-topics)

---

## Architecture Layers

### 1. Presentation Layer (UI)
**Location**: `lib/features/*/presentation/`

**Responsibilities**:
- Display data to the user
- Handle user interactions
- Manage UI state with BLoC/Cubit
- Navigate between screens

**Components**:
- **Pages/Screens**: Full-screen widgets
- **Widgets**: Reusable UI components
- **BLoC/Cubit**: State management and business logic coordination
- **States**: Immutable state representations
- **Events**: User actions or system events

**Rules**:
- Never directly access data sources
- Depend only on Domain layer (use cases)
- UI should be dumb - no business logic
- All business logic goes through BLoC/Cubit

**Example**:
```dart
// Presentation Layer Structure
features/
  auth/
    presentation/
      pages/
        login_page.dart
      widgets/
        login_form.dart
      bloc/
        login_bloc.dart
        login_event.dart
        login_state.dart
```

---

### 2. Domain Layer (Business Logic)
**Location**: `lib/features/*/domain/`

**Responsibilities**:
- Define business rules and use cases
- Define entities and business models
- Define repository contracts (interfaces)
- Pure Dart code - no Flutter dependencies

**Components**:
- **Entities**: Business objects (immutable data classes)
- **Use Cases**: Single responsibility business operations
- **Repository Interfaces**: Abstract contracts for data access

**Rules**:
- No dependencies on outer layers
- Framework-agnostic (pure Dart)
- Single Responsibility Principle per use case
- Entities should be immutable

**Example**:
```dart
// Domain Layer Structure
features/
  auth/
    domain/
      entities/
        user.dart
      repositories/
        auth_repository.dart (abstract)
      usecases/
        login_usecase.dart
        logout_usecase.dart
```

**Use Case Template**:
```dart
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}
```

---

### 3. Data Layer
**Location**: `lib/features/*/data/`

**Responsibilities**:
- Implement repository interfaces from Domain
- Handle data sources (API, Database, Cache)
- Map between data models and domain entities
- Handle data caching strategies

**Components**:
- **Models**: Data transfer objects (DTOs)
- **Data Sources**: API clients, local database, cache
- **Repository Implementations**: Concrete implementations

**Rules**:
- Implements Domain repository interfaces
- Never expose data models to Domain/Presentation
- Always map models to entities
- Handle all data exceptions

**Example**:
```dart
// Data Layer Structure
features/
  auth/
    data/
      models/
        user_model.dart
      datasources/
        auth_remote_datasource.dart
        auth_local_datasource.dart
      repositories/
        auth_repository_impl.dart
```

**Repository Pattern**:
```dart
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  
  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(email, password);
        await localDataSource.cacheUser(userModel);
        return Right(userModel.toEntity());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
```

---

## Project Structure

```
lib/
├── core/                          # Shared functionality
│   ├── constants/                 # App-wide constants
│   ├── di/                        # Dependency injection setup
│   ├── error/                     # Error handling
│   │   ├── exceptions.dart        # Data layer exceptions
│   │   └── failures.dart          # Domain/Presentation failures
│   ├── network/                   # Network configuration
│   │   └── api/                   # API clients (Dio)
│   ├── routes/                    # Navigation/routing
│   ├── themes/                    # UI themes and styles
│   ├── utils/                     # Helper functions
│   │   ├── helpers/
│   │   └── l10n/                  # Localization
│   └── widgets/                   # Reusable widgets
│
├── features/                      # Feature modules
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   ├── home/
│   └── [other features]/
│
└── main.dart                      # App entry point
```

---

## Dependency Rule

**The Golden Rule**: Dependencies point inward only.

```
Presentation → Domain ← Data
     ↓           ↑         ↓
   BLoC     Use Cases   Repositories
     ↓           ↑         ↓
  Widgets    Entities   Data Sources
```

### Dependency Flow:
1. **Presentation** depends on **Domain** (via use cases)
2. **Data** depends on **Domain** (implements repository interfaces)
3. **Domain** depends on nothing (pure business logic)

### Why This Matters:
- Business logic is independent of frameworks
- Easy to test each layer in isolation
- Easy to swap implementations (e.g., different data sources)
- Changes in UI don't affect business logic

---

## Data Flow

### Request Flow (User Action → Data)
```
User Interaction
    ↓
Widget dispatches Event
    ↓
BLoC receives Event
    ↓
BLoC calls Use Case
    ↓
Use Case calls Repository Interface
    ↓
Repository Implementation queries Data Source
    ↓
Data Source fetches from API/DB
    ↓
Model → Entity mapping
    ↓
Result wrapped in Either<Failure, Success>
    ↓
BLoC emits new State
    ↓
Widget rebuilds with new data
```

### Example Flow:
```dart
// 1. User taps login button
onPressed: () {
  context.read<LoginBloc>().add(LoginButtonPressed(email, password));
}

// 2. BLoC handles event
on<LoginButtonPressed>((event, emit) async {
  emit(LoginLoading());
  
  final result = await loginUseCase(
    LoginParams(email: event.email, password: event.password)
  );
  
  result.fold(
    (failure) => emit(LoginError(failure.message)),
    (user) => emit(LoginSuccess(user)),
  );
});

// 3. Use Case executes
Future<Either<Failure, User>> call(LoginParams params) {
  return repository.login(params.email, params.password);
}

// 4. Repository fetches data
Future<Either<Failure, User>> login(String email, String password) async {
  try {
    final userModel = await remoteDataSource.login(email, password);
    return Right(userModel.toEntity());
  } catch (e) {
    return Left(ServerFailure());
  }
}
```

---

## State Management

### BLoC Pattern (Business Logic Component)

**When to Use BLoC**:
- Complex state with multiple events
- Async operations
- State needs to be shared across multiple widgets

**When to Use Cubit**:
- Simple state management
- Direct state changes without events
- Less boilerplate needed

### BLoC Best Practices:

1. **One BLoC per feature/screen**
2. **States should be immutable** (use `copyWith`)
3. **Events should describe what happened** (past tense)
4. **BLoC should never know about widgets**
5. **Use sealed classes/enums for states**

**Example BLoC Structure**:
```dart
// States
abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final User user;
  const LoginSuccess(this.user);
  
  @override
  List<Object> get props => [user];
}

class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
  
  @override
  List<Object> get props => [message];
}

// Events
abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  
  const LoginButtonPressed(this.email, this.password);
  
  @override
  List<Object> get props => [email, password];
}

// BLoC
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  
  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }
  
  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    
    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    
    result.fold(
      (failure) => emit(LoginError(_mapFailureToMessage(failure))),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
```

---

## Dependency Injection

**Tool**: GetIt (Service Locator pattern)

**Setup Location**: `lib/core/di/injection.dart`

### Registration Patterns:

```dart
final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // External dependencies (singleton)
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  
  // Core services (singleton)
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt()),
  );
  
  // Data sources (singleton)
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: getIt()),
  );
  
  // Repositories (singleton)
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );
  
  // Use cases (factory - new instance each time)
  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(getIt()),
  );
  
  // BLoC (factory - new instance per screen)
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(loginUseCase: getIt()),
  );
}
```

### When to Use Each:
- **registerSingleton**: Immediate creation, always same instance
- **registerLazySingleton**: Created on first use, always same instance
- **registerFactory**: New instance every time

---

## Error Handling

### Two-Level Error System:

1. **Exceptions** (Data Layer): Technical failures
2. **Failures** (Domain/Presentation): Business failures

### Exception Types:
```dart
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class ServerException extends AppException {
  const ServerException([String message = 'Server error occurred']) 
      : super(message);
}

class CacheException extends AppException {
  const CacheException([String message = 'Cache error occurred']) 
      : super(message);
}

class NetworkException extends AppException {
  const NetworkException([String message = 'No internet connection']) 
      : super(message);
}
```

### Failure Types:
```dart
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server failure']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache failure']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network failure']) : super(message);
}
```

### Error Flow:
```dart
// Data layer throws exceptions
try {
  final response = await dio.post('/login');
  return UserModel.fromJson(response.data);
} on DioException catch (e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    throw NetworkException('Connection timeout');
  }
  throw ServerException('Server error');
}

// Repository catches exceptions and returns failures
try {
  final user = await remoteDataSource.login(email, password);
  return Right(user.toEntity());
} on ServerException catch (e) {
  return Left(ServerFailure(e.message));
} on NetworkException catch (e) {
  return Left(NetworkFailure(e.message));
}

// BLoC handles failures
result.fold(
  (failure) {
    if (failure is NetworkFailure) {
      emit(LoginError('Check your internet connection'));
    } else {
      emit(LoginError(failure.message));
    }
  },
  (user) => emit(LoginSuccess(user)),
);
```

---

## Testing Strategy

### Test Pyramid:
```
        /\
       /  \  E2E Tests (Few)
      /    \
     /------\  Integration Tests (Some)
    /        \
   /----------\  Unit Tests (Many)
```

### 1. Unit Tests (70%)
**Test**: Use Cases, BLoC logic, Utilities

```dart
void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;
  
  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(mockRepository);
  });
  
  group('LoginUseCase', () {
    test('should return User when repository returns success', () async {
      // Arrange
      final user = User(id: '1', email: 'test@test.com');
      when(mockRepository.login(any, any))
          .thenAnswer((_) async => Right(user));
      
      // Act
      final result = await useCase(LoginParams('email', 'password'));
      
      // Assert
      expect(result, Right(user));
      verify(mockRepository.login('email', 'password'));
    });
  });
}
```

### 2. Widget Tests (20%)
**Test**: Widget rendering, user interactions

```dart
void main() {
  testWidgets('LoginPage shows error message on login failure', 
      (tester) async {
    // Arrange
    final mockBloc = MockLoginBloc();
    when(mockBloc.state).thenReturn(LoginError('Invalid credentials'));
    
    // Act
    await tester.pumpWidget(
      BlocProvider<LoginBloc>.value(
        value: mockBloc,
        child: LoginPage(),
      ),
    );
    
    // Assert
    expect(find.text('Invalid credentials'), findsOneWidget);
  });
}
```

### 3. Integration Tests (10%)
**Test**: Feature flows, navigation, API integration

---

## Advanced Topics

### 1. Feature Modularity
Each feature is self-contained and can be:
- Developed independently
- Tested in isolation
- Removed without affecting others
- Scaled to separate packages

### 2. Either Type (Functional Error Handling)
Using `dartz` package for functional programming:
```dart
// Instead of try-catch everywhere
Either<Failure, User> result = await repository.login();

// Handle both cases explicitly
result.fold(
  (failure) => handleError(failure),
  (user) => handleSuccess(user),
);
```

### 3. Sealed Classes for States
```dart
sealed class LoginState {}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}
class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

// Exhaustive pattern matching
switch (state) {
  case LoginInitial(): // handle
  case LoginLoading(): // handle
  case LoginSuccess(): // handle
  case LoginError(): // handle
  // Compiler ensures all cases covered
}
```

### 4. Repository Cache Strategy
```dart
@override
Future<Either<Failure, List<Service>>> getServices() async {
  if (await networkInfo.isConnected) {
    try {
      final services = await remoteDataSource.getServices();
      await localDataSource.cacheServices(services);
      return Right(services.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  } else {
    try {
      final cachedServices = await localDataSource.getCachedServices();
      return Right(cachedServices.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
```

### 5. Pagination Pattern
```dart
class GetServicesUseCase {
  Future<Either<Failure, PaginatedResult<Service>>> call({
    required int page,
    required int limit,
  }) async {
    return repository.getServices(page: page, limit: limit);
  }
}

// BLoC with pagination
on<LoadMoreServices>((event, emit) async {
  if (state is ServicesLoaded) {
    final currentState = state as ServicesLoaded;
    emit(ServicesLoadingMore(currentState.services));
    
    final result = await getServicesUseCase(
      page: currentState.currentPage + 1,
      limit: 20,
    );
    
    result.fold(
      (failure) => emit(ServicesError(failure.message)),
      (paginatedResult) => emit(ServicesLoaded(
        services: [...currentState.services, ...paginatedResult.data],
        currentPage: paginatedResult.currentPage,
        hasMore: paginatedResult.hasMore,
      )),
    );
  }
});
```

### 6. Value Objects (Domain-Driven Design)
```dart
class Email extends Equatable {
  final String value;
  
  const Email._(this.value);
  
  factory Email(String input) {
    if (!_isValid(input)) {
      throw InvalidEmailException();
    }
    return Email._(input);
  }
  
  static bool _isValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  @override
  List<Object> get props => [value];
}

// Usage in entity
class User {
  final String id;
  final Email email; // Type-safe email
  final Name name;   // Type-safe name
  
  User({required this.id, required this.email, required this.name});
}
```

### 7. Multi-Environment Configuration
```dart
enum Environment { dev, staging, production }

class AppConfig {
  static Environment environment = Environment.dev;
  
  static String get apiBaseUrl {
    switch (environment) {
      case Environment.dev:
        return 'https://dev-api.example.com';
      case Environment.staging:
        return 'https://staging-api.example.com';
      case Environment.production:
        return 'https://api.example.com';
    }
  }
}
```

---

## Summary

### Key Principles:
1. ✅ **Separation of Concerns**: Each layer has one responsibility
2. ✅ **Dependency Rule**: Inner layers don't know about outer layers
3. ✅ **Testability**: Each layer can be tested independently
4. ✅ **Scalability**: Easy to add features without affecting existing code
5. ✅ **Maintainability**: Clear structure makes changes predictable

### Benefits:
- 🎯 Business logic is framework-independent
- 🧪 High test coverage is achievable
- 🔄 Easy to swap implementations
- 📦 Features are modular and isolated
- 👥 Multiple developers can work without conflicts
- 🚀 Scales with team and project size

---

**Last Updated**: June 2026
**Maintainer**: Development Team
