# Contributing Guide

Welcome to the project! This guide will help you contribute effectively while maintaining code quality and consistency.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Development Workflow](#development-workflow)
3. [Git Workflow](#git-workflow)
4. [Code Style Guide](#code-style-guide)
5. [Architecture Guidelines](#architecture-guidelines)
6. [Adding New Features](#adding-new-features)
7. [Testing Requirements](#testing-requirements)
8. [Pull Request Process](#pull-request-process)
9. [Common Patterns](#common-patterns)

---

## Getting Started

### Prerequisites

- Flutter SDK 3.41.2 or higher
- Dart SDK 3.11.0 or higher
- Git
- IDE: VS Code or Android Studio

### Initial Setup

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd home_service_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run code generation** (if needed):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

5. **Run tests**:
   ```bash
   flutter test
   ```

6. **Run linting**:
   ```bash
   flutter analyze
   ```

---

## Development Workflow

### Daily Workflow

1. **Pull latest changes**:
   ```bash
   git checkout main
   git pull origin main
   ```

2. **Create a feature branch**:
   ```bash
   git checkout -b service_details/your-service_details-name
   ```

3. **Make your changes** following the guidelines below

4. **Test your changes**:
   ```bash
   flutter test
   flutter analyze
   ```

5. **Commit and push**:
   ```bash
   git add .
   git commit -m "feat: add user authentication"
   git push origin service_details/your-service_details-name
   ```

6. **Create a Pull Request**

---

## Git Workflow

### Branch Naming Convention

```
<type>/<short-description>

Types:
- feature/  : New features
- fix/      : Bug fixes
- refactor/ : Code refactoring
- docs/     : Documentation changes
- test/     : Adding tests
- chore/    : Maintenance tasks
```

**Examples**:
- `feature/add-payment-gateway`
- `fix/login-button-crash`
- `refactor/optimize-home-screen`
- `docs/update-architecture-guide`

### Commit Message Convention

We follow **Conventional Commits** specification:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `refactor`: Code refactoring
- `docs`: Documentation changes
- `style`: Code formatting
- `test`: Adding tests
- `chore`: Maintenance tasks
- `perf`: Performance improvements

**Examples**:
```bash
feat(auth): add login with Google

- Implement Google Sign-In integration
- Add GoogleAuthDataSource
- Create LoginWithGoogleUseCase
- Update LoginBloc to handle Google login

Closes #123

---

fix(home): resolve crash on service card tap

The service card was crashing when tapped due to null category.
Added null check and default value.

Fixes #456

---

refactor(core): migrate to GetIt for dependency injection

- Replace manual singleton pattern with GetIt
- Create injection.dart configuration
- Update all features to use GetIt
- Add tests for dependency injection

Breaking Change: Old DI pattern no longer supported
```

### Commit Best Practices

✅ **DO**:
- Write clear, descriptive commit messages
- Keep commits focused (one logical change per commit)
- Reference issue numbers
- Use present tense ("add feature" not "added feature")
- Start with lowercase

❌ **DON'T**:
- Commit commented-out code
- Commit TODO comments without tracking
- Make massive commits with unrelated changes
- Use vague messages like "fix bug" or "update code"

---

## Code Style Guide

### Dart Style

Follow the [Official Dart Style Guide](https://dart.dev/guides/language/effective-dart/style).

**Key points**:

1. **Use `dart format`**:
   ```bash
   dart format .
   ```

2. **File naming**: `lowercase_with_underscores.dart`

3. **Class naming**: `UpperCamelCase`
   ```dart
   class UserProfile {}
   class AuthRepository {}
   ```

4. **Variable/Function naming**: `lowerCamelCase`
   ```dart
   String userName = 'John';
   void fetchUserData() {}
   ```

5. **Constants**: `lowerCamelCase` for const, `SCREAMING_SNAKE_CASE` for static const
   ```dart
   const double paddingSize = 16.0;
   static const String API_BASE_URL = 'https://api.example.com';
   ```

6. **Private members**: prefix with `_`
   ```dart
   String _privateVariable;
   void _privateMethod() {}
   ```

### Flutter Style

1. **Widget organization**:
   ```dart
   class MyWidget extends StatelessWidget {
     // 1. Fields
     final String title;
     final VoidCallback onTap;
     
     // 2. Constructor
     const MyWidget({
       Key? key,
       required this.title,
       required this.onTap,
     }) : super(key: key);
     
     // 3. Build method
     @override
     Widget build(BuildContext context) {
       return Container();
     }
     
     // 4. Private methods
     void _handleTap() {}
   }
   ```

2. **Extract complex widgets**:
   ```dart
   // ❌ Bad
   Widget build(BuildContext context) {
     return Column(
       children: [
         Container(
           // 50 lines of complex widget tree
         ),
       ],
     );
   }
   
   // ✅ Good
   Widget build(BuildContext context) {
     return Column(
       children: [
         _buildHeader(),
         _buildBody(),
         _buildFooter(),
       ],
     );
   }
   
   Widget _buildHeader() {
     return Container(/* ... */);
   }
   ```

3. **Use const constructors**:
   ```dart
   // ✅ Good - saves memory and improves performance
   const Text('Hello World')
   const SizedBox(height: 16)
   const Icon(Icons.home)
   ```

4. **Meaningful widget names**:
   ```dart
   // ❌ Bad
   class MyCustomWidget extends StatelessWidget {}
   
   // ✅ Good
   class ServiceCategoryCard extends StatelessWidget {}
   ```

### Documentation

1. **Public APIs must be documented**:
   ```dart
   /// Authenticates a user with email and password.
   ///
   /// Returns [Right<User>] on success or [Left<Failure>] on failure.
   ///
   /// Throws [ServerException] if the server is unreachable.
   Future<Either<Failure, User>> login(String email, String password);
   ```

2. **Complex logic should have inline comments**:
   ```dart
   // Calculate discount based on user tier
   // Premium users get 20%, regular users get 10%
   final discount = user.isPremium ? 0.20 : 0.10;
   ```

3. **TODO comments must have owner and date**:
   ```dart
   // TODO(username, 2026-06-03): Implement caching strategy
   // TODO(username, 2026-06-03): Refactor this method - too complex
   ```

---

## Architecture Guidelines

### Follow Clean Architecture Layers

```
Presentation → Domain ← Data
```

**Rules**:
1. ✅ Presentation depends ONLY on Domain
2. ✅ Data depends ONLY on Domain
3. ✅ Domain depends on NOTHING
4. ❌ Never import Flutter in Domain layer
5. ❌ Never skip layers (Presentation → Data is forbidden)

### SOLID Principles

#### 1. Single Responsibility Principle (SRP)
```dart
// ❌ Bad - Class does too much
class UserManager {
  void saveUser(User user) {}
  void sendEmail(String email) {}
  void logActivity(String activity) {}
}

// ✅ Good - Each class has one responsibility
class UserRepository {
  void saveUser(User user) {}
}

class EmailService {
  void sendEmail(String email) {}
}

class ActivityLogger {
  void logActivity(String activity) {}
}
```

#### 2. Open/Closed Principle (OCP)
```dart
// ✅ Good - Open for extension, closed for modification
abstract class PaymentMethod {
  Future<PaymentResult> process(double amount);
}

class CreditCardPayment implements PaymentMethod {
  @override
  Future<PaymentResult> process(double amount) async {
    // Credit card logic
  }
}

class PayPalPayment implements PaymentMethod {
  @override
  Future<PaymentResult> process(double amount) async {
    // PayPal logic
  }
}

// Adding new payment method doesn't modify existing code
class ApplePayPayment implements PaymentMethod {
  @override
  Future<PaymentResult> process(double amount) async {
    // Apple Pay logic
  }
}
```

#### 3. Liskov Substitution Principle (LSP)
```dart
// ✅ Good - Subtypes are substitutable
abstract class Storage {
  Future<void> save(String key, String value);
  Future<String?> get(String key);
}

class LocalStorage implements Storage {
  @override
  Future<void> save(String key, String value) async {
    // Save locally
  }
  
  @override
  Future<String?> get(String key) async {
    // Get from local
  }
}

class CloudStorage implements Storage {
  @override
  Future<void> save(String key, String value) async {
    // Save to cloud
  }
  
  @override
  Future<String?> get(String key) async {
    // Get from cloud
  }
}

// Both can be used interchangeably
Storage storage = LocalStorage(); // or CloudStorage()
await storage.save('key', 'value');
```

#### 4. Interface Segregation Principle (ISP)
```dart
// ❌ Bad - Fat interface
abstract class Worker {
  void work();
  void eat();
  void sleep();
  void code();
  void design();
}

// ✅ Good - Segregated interfaces
abstract class Workable {
  void work();
}

abstract class Eatable {
  void eat();
}

abstract class Sleepable {
  void sleep();
}

class Developer implements Workable, Eatable, Sleepable {
  @override
  void work() => print('Coding...');
  
  @override
  void eat() => print('Eating...');
  
  @override
  void sleep() => print('Sleeping...');
}
```

#### 5. Dependency Inversion Principle (DIP)
```dart
// ❌ Bad - High-level depends on low-level
class UserProfile {
  final DatabaseHelper database = DatabaseHelper(); // Concrete dependency
  
  void saveProfile() {
    database.save();
  }
}

// ✅ Good - Both depend on abstraction
abstract class UserRepository {
  void saveProfile(User user);
}

class UserProfile {
  final UserRepository repository; // Abstract dependency
  
  UserProfile(this.repository);
  
  void saveProfile(User user) {
    repository.saveProfile(user);
  }
}

class LocalUserRepository implements UserRepository {
  @override
  void saveProfile(User user) {
    // Save locally
  }
}
```

---

## Adding New Features

### Step-by-Step Guide

#### 1. Create Feature Structure

```bash
lib/features/my_feature/
├── data/
│   ├── datasources/
│   │   ├── my_feature_remote_datasource.dart
│   │   └── my_feature_local_datasource.dart
│   ├── models/
│   │   └── my_feature_model.dart
│   └── repositories/
│       └── my_feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── my_feature_entity.dart
│   ├── repositories/
│   │   └── my_feature_repository.dart
│   └── usecases/
│       └── get_my_feature_usecase.dart
└── presentation/
    ├── bloc/
    │   ├── my_feature_bloc.dart
    │   ├── my_feature_event.dart
    │   └── my_feature_state.dart
    ├── pages/
    │   └── my_feature_page.dart
    └── widgets/
        └── my_feature_card.dart
```

#### 2. Domain Layer (Start Here)

**a. Create Entity**:
```dart
// domain/entities/product.dart
class Product extends Equatable {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  
  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
  
  @override
  List<Object> get props => [id, name, price, imageUrl];
}
```

**b. Create Repository Interface**:
```dart
// domain/repositories/product_repository.dart
abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, Product>> getProductById(String id);
}
```

**c. Create Use Case**:
```dart
// domain/usecases/get_products_usecase.dart
class GetProductsUseCase implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;
  
  GetProductsUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return repository.getProducts();
  }
}
```

#### 3. Data Layer

**a. Create Model**:
```dart
// data/models/product_model.dart
class ProductModel extends Product {
  const ProductModel({
    required String id,
    required String name,
    required double price,
    required String imageUrl,
  }) : super(id: id, name: name, price: price, imageUrl: imageUrl);
  
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
    };
  }
  
  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
    );
  }
}
```

**b. Create Data Source**:
```dart
// data/datasources/product_remote_datasource.dart
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  
  ProductRemoteDataSourceImpl({required this.dio});
  
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('/products');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];
        return data.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to fetch products');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    }
  }
}
```

**c. Implement Repository**:
```dart
// data/repositories/product_repository_impl.dart
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  
  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProducts();
        return Right(products.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
  
  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    // Implementation
  }
}
```

#### 4. Presentation Layer

**a. Create States**:
```dart
// presentation/bloc/product_state.dart
abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  
  const ProductLoaded(this.products);
  
  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  
  const ProductError(this.message);
  
  @override
  List<Object> get props => [message];
}
```

**b. Create Events**:
```dart
// presentation/bloc/product_event.dart
abstract class ProductEvent extends Equatable {
  const ProductEvent();
  
  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class RefreshProducts extends ProductEvent {}
```

**c. Create BLoC**:
```dart
// presentation/bloc/product_bloc.dart
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  
  ProductBloc({required this.getProductsUseCase}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<RefreshProducts>(_onRefreshProducts);
  }
  
  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    
    final result = await getProductsUseCase(NoParams());
    
    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (products) => emit(ProductLoaded(products)),
    );
  }
  
  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    // Keep current products while refreshing
    if (state is ProductLoaded) {
      final currentProducts = (state as ProductLoaded).products;
      emit(ProductLoaded(currentProducts)); // Keep showing data
    }
    
    final result = await getProductsUseCase(NoParams());
    
    result.fold(
      (failure) => emit(ProductError(_mapFailureToMessage(failure))),
      (products) => emit(ProductLoaded(products)),
    );
  }
  
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error. Please try again.';
    } else if (failure is NetworkFailure) {
      return 'No internet connection';
    } else {
      return 'Unexpected error occurred';
    }
  }
}
```

**d. Create Page**:
```dart
// presentation/pages/product_page.dart
class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProductBloc>()..add(LoadProducts()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ProductBloc>().add(RefreshProducts());
                },
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductCard(product: product);
                  },
                ),
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
```

#### 5. Register Dependencies

```dart
// core/di/injection.dart

// Add to setupDependencies()

// Data sources
getIt.registerLazySingleton<ProductRemoteDataSource>(
  () => ProductRemoteDataSourceImpl(dio: getIt()),
);

// Repositories
getIt.registerLazySingleton<ProductRepository>(
  () => ProductRepositoryImpl(
    remoteDataSource: getIt(),
    networkInfo: getIt(),
  ),
);

// Use cases
getIt.registerFactory<GetProductsUseCase>(
  () => GetProductsUseCase(getIt()),
);

// BLoC
getIt.registerFactory<ProductBloc>(
  () => ProductBloc(getProductsUseCase: getIt()),
);
```

#### 6. Add Route

```dart
// core/routes/app_routes.dart
class AppRouter {
  static const String products = '/products';
  
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case products:
        return MaterialPageRoute(builder: (_) => ProductPage());
      // ... other routes
    }
  }
}
```

---

## Testing Requirements

### Test Coverage Goals

- **Unit Tests**: 80%+ coverage
- **Widget Tests**: Critical user flows
- **Integration Tests**: Main features

### Writing Tests

#### 1. Unit Test Example

```dart
// test/features/product/domain/usecases/get_products_usecase_test.dart
void main() {
  late GetProductsUseCase useCase;
  late MockProductRepository mockRepository;
  
  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProductsUseCase(mockRepository);
  });
  
  group('GetProductsUseCase', () {
    final tProducts = [
      Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: ''),
      Product(id: '2', name: 'Product 2', price: 20.0, imageUrl: ''),
    ];
    
    test('should return list of products from repository', () async {
      // Arrange
      when(mockRepository.getProducts())
          .thenAnswer((_) async => Right(tProducts));
      
      // Act
      final result = await useCase(NoParams());
      
      // Assert
      expect(result, Right(tProducts));
      verify(mockRepository.getProducts());
      verifyNoMoreInteractions(mockRepository);
    });
    
    test('should return failure when repository fails', () async {
      // Arrange
      when(mockRepository.getProducts())
          .thenAnswer((_) async => Left(ServerFailure()));
      
      // Act
      final result = await useCase(NoParams());
      
      // Assert
      expect(result, Left(ServerFailure()));
    });
  });
}
```

#### 2. BLoC Test Example

```dart
// test/features/product/presentation/bloc/product_bloc_test.dart
void main() {
  late ProductBloc bloc;
  late MockGetProductsUseCase mockGetProductsUseCase;
  
  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    bloc = ProductBloc(getProductsUseCase: mockGetProductsUseCase);
  });
  
  tearDown(() {
    bloc.close();
  });
  
  group('LoadProducts', () {
    final tProducts = [
      Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: ''),
    ];
    
    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductLoaded] when successful',
      build: () {
        when(mockGetProductsUseCase(any))
            .thenAnswer((_) async => Right(tProducts));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadProducts()),
      expect: () => [
        ProductLoading(),
        ProductLoaded(tProducts),
      ],
      verify: (_) {
        verify(mockGetProductsUseCase(NoParams()));
      },
    );
    
    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductError] when fails',
      build: () {
        when(mockGetProductsUseCase(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadProducts()),
      expect: () => [
        ProductLoading(),
        isA<ProductError>(),
      ],
    );
  });
}
```

#### 3. Widget Test Example

```dart
// test/features/product/presentation/pages/product_page_test.dart
void main() {
  late MockProductBloc mockBloc;
  
  setUp(() {
    mockBloc = MockProductBloc();
  });
  
  testWidgets('displays loading indicator when state is ProductLoading',
      (tester) async {
    // Arrange
    when(() => mockBloc.state).thenReturn(ProductLoading());
    
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductBloc>.value(
          value: mockBloc,
          child: ProductPage(),
        ),
      ),
    );
    
    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  
  testWidgets('displays products when state is ProductLoaded',
      (tester) async {
    // Arrange
    final products = [
      Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: ''),
    ];
    when(() => mockBloc.state).thenReturn(ProductLoaded(products));
    
    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductBloc>.value(
          value: mockBloc,
          child: ProductPage(),
        ),
      ),
    );
    
    // Assert
    expect(find.text('Product 1'), findsOneWidget);
  });
}
```

---

## Pull Request Process

### Before Creating PR

1. ✅ Run all tests: `flutter test`
2. ✅ Run analyzer: `flutter analyze`
3. ✅ Format code: `dart format .`
4. ✅ Update documentation if needed
5. ✅ Add/update tests for new code
6. ✅ Rebase on latest main

### PR Template

```markdown
## Description
Brief description of what this PR does.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Related Issue
Closes #(issue number)

## Changes Made
- Change 1
- Change 2
- Change 3

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots here

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings
- [ ] Tests pass locally
```

### PR Review Process

1. **Automated checks** must pass (tests, linting)
2. **Code review** by at least 1 team member
3. **Address feedback** and make changes
4. **Final approval** and merge

### After PR Merged

1. Delete feature branch
2. Pull latest main
3. Close related issues

---

## Common Patterns

### Pattern 1: Loading with Cached Data

```dart
on<RefreshEvent>((event, emit) async {
  // Show cached data while loading
  if (state is DataLoaded) {
    emit(DataRefreshing((state as DataLoaded).data));
  } else {
    emit(DataLoading());
  }
  
  final result = await useCase();
  result.fold(
    (failure) => emit(DataError(failure.message)),
    (data) => emit(DataLoaded(data)),
  );
});
```

### Pattern 2: Optimistic Updates

```dart
on<DeleteItemEvent>((event, emit) async {
  if (state is ItemsLoaded) {
    final currentItems = (state as ItemsLoaded).items;
    
    // Optimistically remove item
    final updatedItems = currentItems.where((i) => i.id != event.id).toList();
    emit(ItemsLoaded(updatedItems));
    
    // Try to delete from server
    final result = await deleteItemUseCase(event.id);
    
    result.fold(
      (failure) {
        // Rollback on failure
        emit(ItemsLoaded(currentItems));
        emit(ItemsError(failure.message));
      },
      (_) {
        // Keep optimistic update
      },
    );
  }
});
```

### Pattern 3: Debounced Search

```dart
on<SearchQueryChanged>(
  (event, emit) async {
    emit(SearchLoading());
    
    final result = await searchUseCase(event.query);
    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (results) => emit(SearchLoaded(results)),
    );
  },
  transformer: debounce(const Duration(milliseconds: 500)),
);

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
```

---

## Questions?

If you have questions or need help:

1. Check the [ARCHITECTURE.md](ARCHITECTURE.md) documentation
2. Check the [CODE_REVIEW_CHECKLIST.md](CODE_REVIEW_CHECKLIST.md)
3. Ask in the team chat
4. Create a discussion issue

---

**Happy Coding! 🚀**

**Last Updated**: June 2026
