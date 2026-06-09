# Splash Screen Guide - English

## 📱 Overview

The Splash Screen is the first screen users see when opening the app. It displays the app logo with an animation and automatically navigates to the next screen based on the user's status.

---

## 🎨 Features

| Feature | Description |
|---------|-------------|
| **Animation** | Gradual fade-in of logo with Curves.easeIn |
| **Background** | Linear gradient from green to white |
| **Duration** | 8 seconds before automatic navigation |
| **Smart Navigation** | Checks onboarding status from cache |
| **Error Handling** | Handles app exit scenarios |

---

## 📂 Architecture

```
SplashScreen (StatefulWidget)
├── _SplashScreenState (with SingleTickerProviderStateMixin)
├── initState()
│   ├── AnimationController (500ms)
│   ├── FadeAnimation
│   ├── Timer (8 seconds)
│   └── Listener
├── _navigateFromSplash()
│   ├── Check onBoarding from CacheHelper
│   └── Navigation:
│       ├─ New → OnboardingScreen
│       └─ Existing → SignInScreen
└── build()
    └── Scaffold
        ├── LinearGradient Background
        └── FadeTransition(Logo)
```

---

## 🔧 Technical Details

### 1. AnimationController

```dart
late final AnimationController _controller;
late final Animation<double> _fadeAnimation;

@override
void initState() {
  super.initState();
  
  // Create animation controller
  _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  
  // Create fade animation
  _fadeAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  
  // Start animation
  _controller.forward();
  
  // Schedule navigation after 8 seconds
  Timer(const Duration(seconds: 8), _navigateFromSplash);
  
  // Monitor animation values (for debugging)
  _controller.addListener(() {
    debugPrint('Splash animation value: ${_controller.value}');
  });
}
```

### 2. Navigation Logic

```dart
void _navigateFromSplash() async {
  // Check if widget still exists
  if (!mounted) return;
  
  // Check onboarding from cache
  final bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  
  // Determine destination
  final route = (onBoarding != null && onBoarding)
      ? AppRouter.signIn          // Existing user
      : AppRouter.onboarding;     // New user
  
  // Navigate
  context.go(route);
}
```

### 3. Resource Cleanup

```dart
@override
void dispose() {
  _controller.dispose();  // Release AnimationController
  super.dispose();
}
```

---

## 🎨 UI Layout

### Widget Layout

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.greenPrimary, AppColors.white],
          stops: [0.0, 0.9],  // Gradient ends at 90%
        ),
      ),
      child: Stack(
        children: [
          // Background with Opacity at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.5.sh,  // 50% of screen height
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                AppAssets.topographicBg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Logo in center with Animation
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                AppAssets.logo,
                width: 150.w,
                height: 150.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
```

---

## 📊 User Flow

```
┌─────────────────────────────┐
│  App Launch                 │
└──────────┬──────────────────┘
           ↓
┌─────────────────────────────┐
│  SplashScreen Created       │
└──────────┬──────────────────┘
           ↓
┌─────────────────────────────┐
│  initState()                │
│  ├─ AnimationController     │
│  ├─ Timer (8 seconds)       │
│  └─ forward() Starts Anim   │
└──────────┬──────────────────┘
           ↓
         (8 seconds)
           ↓
┌─────────────────────────────┐
│  _navigateFromSplash()      │
│  ├─ Check CacheHelper       │
│  └─ Determine Destination   │
└──────────┬──────────────────┘
           ↓
      ┌──────────┐
      │          │
   Checked
      │          │
   True      False
      │          │
      ↓          ↓
  SignIn    Onboarding
  Screen      Screen
```

---

## 🔍 Use Cases

### Case 1: New User
```
Splash (8 seconds)
    ↓
CacheHelper.getData('onBoarding') = null or false
    ↓
Onboarding Screen
```

### Case 2: Existing User
```
Splash (8 seconds)
    ↓
CacheHelper.getData('onBoarding') = true
    ↓
SignIn Screen
```

### Case 3: App Closed During Splash
```
Splash Running
    ↓
User Closes App
    ↓
if (!mounted) return;
    ↓
No Navigation (Widget was removed)
```

---

## ⚡ Performance Standards

| Element | Standard | Notes |
|---------|----------|-------|
| **Animation Duration** | 500ms | Smooth and fast |
| **Wait Time** | 8 seconds | Adequate for viewing |
| **Image Size** | 150x150 | Performance optimized |
| **Opacity** | 0.25 | Clear without blocking |

---

## 📝 Important Notes

### 1. Mounted Check
```dart
// ✅ Correct: Check if widget exists
if (!mounted) return;

// ❌ Wrong: Navigate from removed widget
context.go(AppRouter.home);  // May cause error
```

### 2. dispose() is Essential
```dart
// ✅ Correct: Release resources
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

// ❌ Wrong: Not releasing resources causes memory leak
```

### 3. Timer Duration Adjustment
```dart
// For development: Use shorter time
Timer(const Duration(seconds: 2), _navigateFromSplash);

// For production: 8 seconds is adequate
Timer(const Duration(seconds: 8), _navigateFromSplash);
```

---

## 🧪 Testing

### Widget Test
```dart
testWidgets('SplashScreen displays logo', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Verify logo exists
  expect(find.byType(FadeTransition), findsOneWidget);
});

testWidgets('SplashScreen navigates after timer', 
    (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Wait 8 seconds
  await tester.pumpAndSettle(const Duration(seconds: 8));
  
  // Verify navigation
  expect(find.byType(OnboardingScreen), findsOneWidget);
});
```

---

## 🔗 Related Files

| File | Description |
|------|-------------|
| `AppAssets` | Contains image paths |
| `AppColors` | Contains color definitions |
| `AppRouter` | Contains route definitions |
| `CacheHelper` | Contains cache utilities |

---

## 📚 Practical Examples

### Add Sound Effect
```dart
@override
void initState() {
  super.initState();
  
  // Play start sound
  _playStartSound();
  
  // Timer and Animation...
}

Future<void> _playStartSound() async {
  // Use audio_players or similar
  // await audioPlayer.play(AssetSource('sounds/splash.mp3'));
}
```

### Add Brand Logo Animation
```dart
// Use ScaleTransition instead of FadeTransition
ScaleTransition(
  scale: _scaleAnimation,
  child: Image.asset(AppAssets.logo, ...),
)

// In initState:
_scaleAnimation = Tween<double>(begin: 0.5, end: 1.0)
    .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
```

---

## ✅ Checklist

- [ ] Logo displays correctly
- [ ] Fade animation is smooth
- [ ] Onboarding is saved in cache
- [ ] Navigation works properly
- [ ] Mounted state is handled
- [ ] Resources are cleaned up
- [ ] Images are optimized
- [ ] Comprehensive testing

---

**Last Updated:** 2024
**Version:** 1.0
