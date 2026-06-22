# Remember Me - Quick Setup

## What Changed?

✅ Remember Me functionality is now fully implemented!

## The Problem It Solves

**Before**: User checks "Remember Me" → Nothing happened  
**Now**: User checks "Remember Me" → Credentials saved → Auto-login on next app launch

## 3 Simple Steps to Enable

### Step 1: Update main.dart

Add a splash screen that checks for auto-login:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<AuthCubit>(
        create: (_) => getIt<AuthCubit>(),
        child: const SplashScreen(), // ← Check Remember Me here
      ),
    );
  }
}
```

### Step 2: Create SplashScreen

```dart
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Try auto-login with Remember Me
    context.read<AuthCubit>().autoLoginWithRememberMe();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          // Auto-login successful
          context.go(AppRouter.home);
        } else if (state is AuthInitial) {
          // No Remember Me, show sign-in
          context.go(AppRouter.signIn);
        }
      },
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
```

### Step 3: Add Logout Function

```dart
// In your profile or settings screen
ElevatedButton(
  onPressed: () async {
    // Logout and clear Remember Me
    await context.read<AuthCubit>().logout();
    context.go(AppRouter.signIn);
  },
  child: Text('تسجيل الخروج'),
)
```

That's it! 🎉

## How It Works

### User Flow

1. **Sign In Screen**: User enters email, password, checks "Remember Me"
2. **Login Button**: Calls `loginWithEmail(email, password, rememberMe: true)`
3. **AuthCubit**: Saves credentials to LocalDataSource
4. **Next Launch**: SplashScreen calls `autoLoginWithRememberMe()`
5. **Auto-Login**: Retrieves saved credentials and logs in automatically

## Methods You Need

### In Sign In Screen (Already Done ✓)

```dart
context.read<AuthCubit>().loginWithEmail(
  email,
  password,
  rememberMe: _rememberMe,  // User's checkbox
);
```

### On App Startup (You need to add)

```dart
// Call this in SplashScreen
await context.read<AuthCubit>().autoLoginWithRememberMe();
```

### On Logout

```dart
// Call this when user logs out
await context.read<AuthCubit>().logout();
```

## Data Saved

When Remember Me is enabled, this data is saved locally:

```
remember_me_enabled = true
remember_me_email = "user@example.com"
remember_me_password = "password123"
```

When user logs out or unchecks Remember Me, all data is deleted.

## Testing

### Test Remember Me Save

```dart
// Sign in with Remember Me checked
await context.read<AuthCubit>().loginWithEmail(
  'test@example.com',
  'password123',
  rememberMe: true,
);
```

### Test Auto-Login

```dart
// Simulate next app launch
await context.read<AuthCubit>().autoLoginWithRememberMe();
// Should auto-login without user input
```

### Test Logout

```dart
// Clear Remember Me and logout
await context.read<AuthCubit>().logout();
// Next launch will show sign-in screen
```

## Common Issues

### Q: Auto-login isn't working?
**A**: Make sure you're calling `autoLoginWithRememberMe()` on app startup in your splash screen.

### Q: Credentials aren't being saved?
**A**: Verify that `rememberMe: true` is being passed to `loginWithEmail()`.

### Q: Logout isn't clearing Remember Me?
**A**: Make sure you're calling the `logout()` method on the AuthCubit.

## Security Note ⚠️

The current implementation stores passwords in plain text. For production:

✅ Use `flutter_secure_storage` instead of SharedPreferences  
✅ Encrypt passwords before storing  
✅ Use refresh tokens instead of passwords  
✅ Add biometric authentication  

## Files Changed

- `auth_cubit.dart` - Added Remember Me support
- `auth_local_datasource.dart` - Added Remember Me interface
- `auth_local_datasource_real.dart` - Implemented Remember Me
- `auth_local_datasource_impl.dart` - Added Mock Remember Me
- `sing_in.dart` - Pass rememberMe to Cubit (already done)

## API Methods

### LocalDataSource

```dart
// Save
await localDataSource.setRememberMeEnabled(true);
await localDataSource.saveRememberMeEmail('email@example.com');
await localDataSource.saveRememberMePassword('password');

// Retrieve
final enabled = await localDataSource.isRememberMeEnabled();
final email = await localDataSource.getRememberedEmail();
final password = await localDataSource.getRememberedPassword();

// Clear
await localDataSource.clearRememberMeData();
```

### AuthCubit

```dart
// Sign in with Remember Me
await context.read<AuthCubit>().loginWithEmail(
  email,
  password,
  rememberMe: true,
);

// Auto-login on app startup
await context.read<AuthCubit>().autoLoginWithRememberMe();

// Logout
await context.read<AuthCubit>().logout();
```

## Real World Example

```dart
// main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<AuthCubit>(
        create: (_) => getIt<AuthCubit>(),
        child: const InitialPage(),
      ),
      routes: {
        '/splash': (_) => const SplashScreen(),
        '/signin': (_) => const SingIn(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}

// InitialPage - Routes to splash on startup
class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is AuthInitial) {
          Navigator.of(context).pushReplacementNamed('/signin');
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const SplashScreen();
          }
          return const SplashScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    Future.microtask(() {
      context.read<AuthCubit>().autoLoginWithRememberMe();
    });
  }
}
```

---

**Status**: Ready to integrate!

For more details, see `REMEMBER_ME_IMPLEMENTATION.md`
