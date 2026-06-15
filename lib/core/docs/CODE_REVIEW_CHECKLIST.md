# Code Review Checklist

Use this checklist when reviewing pull requests to ensure code quality, maintainability, and adherence to best practices.

## Table of Contents

1. [General Code Quality](#general-code-quality)
2. [Clean Architecture Compliance](#clean-architecture-compliance)
3. [SOLID Principles](#solid-principles)
4. [Clean Code Principles](#clean-code-principles)
5. [Flutter Best Practices](#flutter-best-practices)
6. [State Management (BLoC)](#state-management-bloc)
7. [Error Handling](#error-handling)
8. [Performance](#performance)
9. [Security](#security)
10. [Testing](#testing)
11. [Documentation](#documentation)
12. [Git & Commits](#git--commits)

---

## General Code Quality

### ✅ Code Functionality
- [ ] Code does what it's supposed to do
- [ ] Edge cases are handled
- [ ] No obvious bugs or logical errors
- [ ] All acceptance criteria met
- [ ] No breaking changes (or documented if necessary)

### ✅ Code Readability
- [ ] Code is self-explanatory
- [ ] Variable/function names are clear and descriptive
- [ ] No magic numbers or strings (use constants)
- [ ] Complex logic has explanatory comments
- [ ] No commented-out code (use git history instead)

### ✅ Code Organization
- [ ] Code is in the correct layer (Presentation/Domain/Data)
- [ ] Files are in the correct directories
- [ ] File names follow naming conventions
- [ ] Code is properly formatted (`dart format`)
- [ ] No duplicate code (DRY principle)

---

## Clean Architecture Compliance

### ✅ Layer Separation
- [ ] **Presentation** layer only depends on Domain
- [ ] **Domain** layer has no dependencies on outer layers
- [ ] **Data** layer only depends on Domain
- [ ] No Flutter imports in Domain layer
- [ ] No circular dependencies between features

### ✅ Domain Layer
```dart
// ✅ Check these rules:
```
- [ ] Entities are immutable
- [ ] Entities extend `Equatable` for value comparison
- [ ] Repository interfaces are abstract classes
- [ ] Use cases have single responsibility
- [ ] Use cases implement `UseCase<Type, Params>` pattern
- [ ] No business logic in entities (only data)

**Example**:
```dart
// ✅ Good Domain Entity
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  
  const User({
    required this.id,
    required this.email,
    required this.name,
  });
  
  @override
  List<Object> get props => [id, email, name];
}

// ❌ Bad - Has business logic
class User {
  String id;
  String email;
  
  void sendEmail() { // Business logic shouldn't be here
    // ...
  }
}
```

### ✅ Data Layer
- [ ] Models extend their corresponding entities
- [ ] Models have `fromJson()` and `toJson()` methods
- [ ] Models have `toEntity()` method
- [ ] Data sources are abstract with concrete implementations
- [ ] Repository implementations map models to entities
- [ ] Exceptions are caught and converted to Failures

**Example**:
```dart
// ✅ Good Model
class UserModel extends User {
  const UserModel({
    required String id,
    required String email,
    required String name,
  }) : super(id: id, email: email, name: name);
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }
  
  User toEntity() => this; // Already extends User
}
```

### ✅ Presentation Layer
- [ ] BLoC/Cubit is used for state management
- [ ] Widgets only call Use Cases through BLoC
- [ ] No business logic in widgets
- [ ] States are immutable
- [ ] Events/Actions describe what happened
- [ ] BLoC doesn't import widgets

---

## SOLID Principles

### ✅ Single Responsibility Principle (SRP)
- [ ] Each class has one reason to change
- [ ] Functions do one thing well
- [ ] Use cases are focused on single operations
- [ ] No "god classes" that do everything

**Check**:
```dart
// ❌ Bad - Multiple responsibilities
class UserService {
  void saveUser() {}
  void sendEmail() {}
  void generateReport() {}
  void logActivity() {}
}

// ✅ Good - Single responsibility
class UserRepository {
  void saveUser() {}
}
class EmailService {
  void sendEmail() {}
}
class ReportGenerator {
  void generateReport() {}
}
```

### ✅ Open/Closed Principle (OCP)
- [ ] Classes are open for extension, closed for modification
- [ ] New features added without changing existing code
- [ ] Use abstraction and polymorphism

**Check**:
```dart
// ✅ Good - Can add payment methods without modifying existing code
abstract class PaymentProcessor {
  Future<void> processPayment(double amount);
}

class CreditCardProcessor implements PaymentProcessor {
  @override
  Future<void> processPayment(double amount) async {
    // Process credit card
  }
}

class PayPalProcessor implements PaymentProcessor {
  @override
  Future<void> processPayment(double amount) async {
    // Process PayPal
  }
}
```

### ✅ Liskov Substitution Principle (LSP)
- [ ] Derived classes can substitute base classes
- [ ] Implementations don't break contracts
- [ ] Method signatures match interfaces

**Check**:
```dart
// ✅ Both implementations are substitutable
abstract class Cache {
  Future<String?> get(String key);
  Future<void> set(String key, String value);
}

class MemoryCache implements Cache {
  @override
  Future<String?> get(String key) async { /* ... */ }
  
  @override
  Future<void> set(String key, String value) async { /* ... */ }
}

class DiskCache implements Cache {
  @override
  Future<String?> get(String key) async { /* ... */ }
  
  @override
  Future<void> set(String key, String value) async { /* ... */ }
}
```

### ✅ Interface Segregation Principle (ISP)
- [ ] Interfaces are small and focused
- [ ] Classes don't implement unused methods
- [ ] No fat interfaces

**Check**:
```dart
// ✅ Good - Small, focused interfaces
abstract class Readable {
  Future<String> read();
}

abstract class Writable {
  Future<void> write(String data);
}

abstract class Deletable {
  Future<void> delete();
}

// Implementation chooses what it needs
class File implements Readable, Writable, Deletable {
  @override
  Future<String> read() async { /* ... */ }
  
  @override
  Future<void> write(String data) async { /* ... */ }
  
  @override
  Future<void> delete() async { /* ... */ }
}
```

### ✅ Dependency Inversion Principle (DIP)
- [ ] High-level modules don't depend on low-level modules
- [ ] Both depend on abstractions
- [ ] Dependencies are injected (via constructor)
- [ ] Using GetIt for dependency injection

**Check**:
```dart
// ✅ Good - Depends on abstraction
class LoginBloc {
  final LoginUseCase loginUseCase; // Abstract dependency
  
  LoginBloc({required this.loginUseCase});
}

// ❌ Bad - Depends on concrete class
class LoginBloc {
  final ApiClient apiClient = ApiClient(); // Concrete dependency
}
```

---

## Clean Code Principles

### ✅ Meaningful Names
- [ ] Names reveal intent
- [ ] Names are pronounceable
- [ ] Names are searchable
- [ ] No abbreviations (unless common: `id`, `url`)
- [ ] Boolean variables start with `is`, `has`, `should`

**Examples**:
```dart
// ✅ Good
bool isUserLoggedIn;
bool hasPermission;
bool shouldShowNotification;
String userEmail;
int productCount;

// ❌ Bad
bool flag;
String em;
int cnt;
String d; // What is 'd'?
```

### ✅ Functions
- [ ] Functions are small (ideally < 20 lines)
- [ ] Functions do one thing
- [ ] Function names are verbs
- [ ] Function parameters are limited (max 3-4)
- [ ] No side effects
- [ ] Consistent abstraction level

**Check**:
```dart
// ✅ Good - Small, single purpose
Future<User> getUserById(String id) async {
  final response = await _apiClient.get('/users/$id');
  return UserModel.fromJson(response.data);
}

// ❌ Bad - Does too much
Future<void> handleUser(String id) async {
  final user = await getUser(id);
  saveToCache(user);
  updateUI(user);
  sendAnalytics(user);
  notifyObservers(user);
}
```

### ✅ Comments
- [ ] Code is self-explanatory (comments not needed for obvious code)
- [ ] Comments explain **why**, not **what**
- [ ] No commented-out code
- [ ] TODO comments have owner and date
- [ ] Public APIs are documented

**Check**:
```dart
// ❌ Bad - Obvious comment
// Get the user name
final name = user.name;

// ✅ Good - Explains why
// Use cached data to avoid excessive API calls during pagination
final cachedUsers = await _cache.getUsers();

// ✅ Good - TODO with context
// TODO(username, 2026-06-03): Implement exponential backoff for retries
```

### ✅ Error Handling
- [ ] Errors are not ignored
- [ ] Specific exceptions are caught (not generic `catch`)
- [ ] Error messages are clear and actionable
- [ ] Errors are logged appropriately

**Check**:
```dart
// ✅ Good
try {
  await apiClient.post('/data', data: body);
} on DioException catch (e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    throw NetworkException('Connection timeout - check your internet');
  } else if (e.response?.statusCode == 401) {
    throw AuthException('Session expired - please login again');
  }
  throw ServerException('Server error - please try again later');
}

// ❌ Bad
try {
  await apiClient.post('/data', data: body);
} catch (e) {
  // Ignored or generic handling
  print('Error: $e');
}
```

### ✅ Code Structure
- [ ] No nested conditionals (max depth: 2)
- [ ] Early returns to avoid nesting
- [ ] Extract complex conditionals to methods
- [ ] Use polymorphism over switch/if-else chains

**Check**:
```dart
// ✅ Good - Early returns
String getUserStatus(User user) {
  if (!user.isActive) return 'Inactive';
  if (user.isPremium) return 'Premium';
  return 'Regular';
}

// ❌ Bad - Nested conditionals
String getUserStatus(User user) {
  if (user.isActive) {
    if (user.isPremium) {
      return 'Premium';
    } else {
      return 'Regular';
    }
  } else {
    return 'Inactive';
  }
}
```

---

## Flutter Best Practices

### ✅ Widget Structure
- [ ] `const` constructors used where possible
- [ ] Complex widgets are extracted into separate methods/classes
- [ ] Widget tree depth is reasonable (< 5 levels)
- [ ] Keys used for lists and dynamic widgets
- [ ] BuildContext is not stored (used immediately)

**Check**:
```dart
// ✅ Good - const and extracted
Widget build(BuildContext context) {
  return Scaffold(
    appBar: _buildAppBar(),
    body: _buildBody(),
    floatingActionButton: _buildFAB(),
  );
}

// ❌ Bad - No const, deep nesting
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Container(/* ... */),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
```

### ✅ State Management
- [ ] StatefulWidget only when state needed
- [ ] State is minimal and necessary
- [ ] `setState` updates only changed properties
- [ ] No business logic in widgets (use BLoC)

### ✅ Performance
- [ ] No expensive operations in build()
- [ ] Lists use `ListView.builder` for large data
- [ ] Images are cached and optimized
- [ ] Unnecessary rebuilds are avoided
- [ ] Keys used appropriately in lists

**Check**:
```dart
// ✅ Good - Lazy loading
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemCard(item: items[index]);
  },
)

// ❌ Bad - Builds all items at once
ListView(
  children: items.map((item) => ItemCard(item: item)).toList(),
)
```

### ✅ Null Safety
- [ ] No unnecessary null checks
- [ ] Null-aware operators used correctly (`?.`, `??`, `!`)
- [ ] Required parameters marked as `required`
- [ ] Late variables used carefully

---

## State Management (BLoC)

### ✅ BLoC Structure
- [ ] States are immutable (use `Equatable`)
- [ ] Events describe past actions (past tense names)
- [ ] State changes only through events
- [ ] BLoC disposed properly
- [ ] No UI imports in BLoC

**Check**:
```dart
// ✅ Good - Immutable state with Equatable
class UserState extends Equatable {
  final User? user;
  final bool isLoading;
  final String? error;
  
  const UserState({
    this.user,
    this.isLoading = false,
    this.error,
  });
  
  UserState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
  
  @override
  List<Object?> get props => [user, isLoading, error];
}

// ✅ Good - Event describes what happened
class UserLoggedIn extends UserEvent {
  final String userId;
  const UserLoggedIn(this.userId);
  
  @override
  List<Object> get props => [userId];
}
```

### ✅ BLoC Usage
- [ ] BLoC provided at correct level (not globally unless needed)
- [ ] BLoC closed/disposed properly
- [ ] BlocBuilder/BlocListener used appropriately
- [ ] Context used correctly (no storing context)

**Check**:
```dart
// ✅ Good - BLoC provided at page level
class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductBloc>()..add(LoadProducts()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          // Build UI based on state
        },
      ),
    );
  }
}
```

---

## Error Handling

### ✅ Exception/Failure Pattern
- [ ] Data layer throws Exceptions
- [ ] Domain/Presentation use Failures
- [ ] Either<Failure, Success> pattern used
- [ ] Error messages are user-friendly
- [ ] Errors are logged for debugging

**Check**:
```dart
// ✅ Good - Repository returns Either
@override
Future<Either<Failure, User>> getUser(String id) async {
  try {
    final userModel = await remoteDataSource.getUser(id);
    return Right(userModel.toEntity());
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } on NetworkException {
    return Left(NetworkFailure('No internet connection'));
  } catch (e) {
    return Left(UnexpectedFailure('An unexpected error occurred'));
  }
}

// ✅ Good - BLoC handles failures
result.fold(
  (failure) {
    String message = 'Something went wrong';
    if (failure is NetworkFailure) {
      message = 'Please check your internet connection';
    } else if (failure is ServerFailure) {
      message = 'Server error. Please try again.';
    }
    emit(UserError(message));
  },
  (user) => emit(UserLoaded(user)),
);
```

### ✅ User-Facing Errors
- [ ] Error messages are clear and actionable
- [ ] Technical details hidden from users
- [ ] Retry mechanisms provided where appropriate
- [ ] Loading states shown during async operations

---

## Performance

### ✅ General Performance
- [ ] No unnecessary rebuilds
- [ ] Async operations don't block UI
- [ ] Lists are lazy-loaded
- [ ] Images are cached and compressed
- [ ] No memory leaks (streams closed, listeners removed)

### ✅ Network Performance
- [ ] API calls are batched when possible
- [ ] Pagination implemented for large datasets
- [ ] Caching strategy implemented
- [ ] Retry logic with exponential backoff
- [ ] Request timeouts configured

**Check**:
```dart
// ✅ Good - Pagination
Future<Either<Failure, List<Product>>> getProducts({
  required int page,
  required int limit,
}) async {
  final response = await dio.get(
    '/products',
    queryParameters: {
      'page': page,
      'limit': limit,
    },
  );
  // ...
}

// ✅ Good - Caching
@override
Future<Either<Failure, User>> getUser(String id) async {
  // Try cache first
  try {
    final cachedUser = await localDataSource.getCachedUser(id);
    if (cachedUser != null) {
      return Right(cachedUser.toEntity());
    }
  } catch (_) {}
  
  // Fetch from network
  try {
    final user = await remoteDataSource.getUser(id);
    await localDataSource.cacheUser(user);
    return Right(user.toEntity());
  } catch (e) {
    return Left(ServerFailure());
  }
}
```

### ✅ Build Performance
- [ ] Const constructors maximize widget reuse
- [ ] Expensive computations moved out of build()
- [ ] Keys used for widget identity in lists
- [ ] RepaintBoundary used for complex widgets

---

## Security

### ✅ Data Security
- [ ] No sensitive data in logs
- [ ] No hardcoded API keys or secrets
- [ ] Secure storage used for sensitive data
- [ ] User input is validated and sanitized
- [ ] API tokens refreshed properly

**Check**:
```dart
// ✅ Good - Secure token storage
class AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'auth_token', value: token);
  }
}

// ❌ Bad - Hardcoded credentials
const String API_KEY = 'sk-1234567890abcdef'; // Never do this!

// ❌ Bad - Logging sensitive data
print('User password: ${user.password}'); // Never log passwords!
```

### ✅ API Security
- [ ] HTTPS used for all API calls
- [ ] Authentication tokens included in requests
- [ ] API errors don't expose sensitive info
- [ ] Rate limiting considered

---

## Testing

### ✅ Test Coverage
- [ ] Unit tests for use cases (80%+ coverage)
- [ ] Unit tests for BLoC logic
- [ ] Widget tests for critical flows
- [ ] Integration tests for main features
- [ ] Edge cases tested

### ✅ Test Quality
- [ ] Tests follow AAA pattern (Arrange, Act, Assert)
- [ ] Tests are independent (no shared state)
- [ ] Tests have descriptive names
- [ ] Tests test one thing
- [ ] Mocks used appropriately

**Check**:
```dart
// ✅ Good test structure
test('should return User when login is successful', () async {
  // Arrange
  final email = 'test@example.com';
  final password = 'password123';
  final expectedUser = User(id: '1', email: email, name: 'Test');
  
  when(mockRepository.login(email, password))
      .thenAnswer((_) async => Right(expectedUser));
  
  // Act
  final result = await useCase(LoginParams(email, password));
  
  // Assert
  expect(result, Right(expectedUser));
  verify(mockRepository.login(email, password));
  verifyNoMoreInteractions(mockRepository);
});
```

### ✅ Test Organization
- [ ] Tests mirror source code structure
- [ ] Test files end with `_test.dart`
- [ ] Shared test utilities in separate files
- [ ] Mock classes properly defined

---

## Documentation

### ✅ Code Documentation
- [ ] Public APIs have doc comments (`///`)
- [ ] Complex algorithms explained
- [ ] README updated if needed
- [ ] CHANGELOG updated for releases

**Check**:
```dart
/// Authenticates a user with email and password.
///
/// Returns [Right<User>] with user data on success,
/// or [Left<Failure>] with error details on failure.
///
/// Throws [ServerException] if the API request fails.
/// Throws [NetworkException] if there's no internet connection.
///
/// Example:
/// ```dart
/// final result = await repository.login('user@example.com', 'password');
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (user) => print('Welcome ${user.name}'),
/// );
/// ```
Future<Either<Failure, User>> login(
  String email,
  String password,
);
```

### ✅ Feature Documentation
- [ ] New features documented in README
- [ ] API changes documented
- [ ] Migration guides for breaking changes
- [ ] Architecture decisions recorded (ADR)

---

## Git & Commits

### ✅ Commit Quality
- [ ] Commits are atomic (one logical change)
- [ ] Commit messages follow convention
- [ ] Commit messages are descriptive
- [ ] No "WIP" or "temp" commits in PR

**Check**:
```bash
# ✅ Good commit messages
feat(auth): add Google Sign-In integration
fix(home): resolve service card crash on tap
refactor(core): migrate to GetIt dependency injection
docs(architecture): update clean architecture guide

# ❌ Bad commit messages
update
fix bug
WIP
changes
```

### ✅ PR Quality
- [ ] PR has clear title and description
- [ ] PR references related issues
- [ ] PR is focused (not too large)
- [ ] Screenshots included for UI changes
- [ ] Breaking changes documented

### ✅ Branch Hygiene
- [ ] Branch name follows convention
- [ ] Branch is up-to-date with main
- [ ] No merge commits (use rebase)
- [ ] Branch deleted after merge

---

## Final Checklist

Before approving a PR, ensure:

- [ ] All automated checks pass (tests, linting)
- [ ] Code follows project conventions
- [ ] Clean Architecture principles followed
- [ ] SOLID principles applied
- [ ] No code smells or anti-patterns
- [ ] Tests are comprehensive
- [ ] Documentation is updated
- [ ] Performance impact considered
- [ ] Security reviewed
- [ ] No breaking changes (or properly documented)

---

## Code Review Etiquette

### For Reviewers:
- ✅ Be respectful and constructive
- ✅ Explain the "why" behind suggestions
- ✅ Approve when code meets standards
- ✅ Request changes for significant issues
- ✅ Use "nit" for minor suggestions

### For Authors:
- ✅ Respond to all comments
- ✅ Ask for clarification if needed
- ✅ Don't take feedback personally
- ✅ Update PR based on feedback
- ✅ Resolve conversations when addressed

---

## Common Issues Checklist

### 🚨 Red Flags (Must Fix)
- [ ] Hardcoded credentials or API keys
- [ ] Security vulnerabilities
- [ ] Memory leaks
- [ ] Breaking changes without documentation
- [ ] Failed tests
- [ ] Code that crashes the app

### ⚠️ Yellow Flags (Should Fix)
- [ ] Code duplication
- [ ] Complex methods (> 30 lines)
- [ ] Missing error handling
- [ ] No tests for new code
- [ ] Poor naming
- [ ] Commented-out code

### 💡 Suggestions (Nice to Have)
- [ ] Could be more performant
- [ ] Could be more readable
- [ ] Minor refactoring opportunities
- [ ] Additional documentation
- [ ] More comprehensive tests

---

**Remember**: The goal is to maintain code quality while being supportive of contributors. Good code reviews make the codebase better and help developers grow! 🚀

**Last Updated**: June 2026
