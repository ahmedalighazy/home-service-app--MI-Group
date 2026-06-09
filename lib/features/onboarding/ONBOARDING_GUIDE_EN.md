# Onboarding Screen Guide - English

## 📱 Overview

The Onboarding Screen provides an interactive introduction to the app's main features. It consists of two steps that users can navigate through with options to skip or proceed.

---

## 🎯 Features

| Feature | Description |
|---------|-------------|
| **PageView** | Smooth transitions between steps |
| **Skip Button** | Direct navigation to login |
| **Next/Start Buttons** | Progress through steps or start |
| **Page Indicators** | Visual indicators of current page |
| **Cache Integration** | Save onboarding completion state |

---

## 📂 Architecture

```
OnboardingScreen (StatefulWidget)
├── _OnboardingScreenState
├── PageController
├── int _currentPage
├── PageView
│   ├── OnboardingStepOneContent
│   └── OnboardingStepTwoContent
└── States:
    ├─ _nextPage()
    ├─ _skipToEnd()
    └─ _finishOnboarding()
```

---

## 🔧 Technical Details

### 1. Basic Variables

```dart
class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
```

### 2. Page Navigation

#### The _nextPage() Function
```dart
void _nextPage() {
  if (_currentPage == 0) {
    // On first page: go to second
    setState(() => _currentPage = 1);
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  } else {
    // On second page: finish onboarding
    _finishOnboarding();
  }
}
```

**Illustration:**
```
┌─────────────────┐         ┌─────────────────┐
│  Onboarding 1   │         │  Onboarding 2   │
│                 │         │                 │
│  [Next Button]  ├────────→│  [Start Button] │
│  [Skip Button]  │         │                 │
└─────────────────┘         └────────┬────────┘
                                     │
                            ┌────────v────────┐
                            │  Save to Cache  │
                            │  Go to Sign In  │
                            └─────────────────┘
```

#### The _skipToEnd() Function
```dart
void _skipToEnd() {
  // Skip directly to login
  _finishOnboarding();
}
```

#### The _finishOnboarding() Function
```dart
void _finishOnboarding() {
  // Save state
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    // Check if widget exists
    if (!mounted) return;
    
    // Navigate to login
    if (value) {
      context.go(AppRouter.signIn);
    }
  });
}
```

### 3. PageView with Monitoring

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: PageView(
      controller: _pageController,
      
      // Monitor page changes
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      
      // Pages
      children: [
        // Screen 1: Onboarding Step One
        OnboardingStepOneContent(
          onNext: _nextPage,
          onSkip: _skipToEnd,
          currentPage: _currentPage,
        ),

        // Screen 2: Onboarding Step Two (Final)
        OnboardingStepTwoContent(
          onStart: _finishOnboarding,
          currentPage: _currentPage,
        ),
      ],
    ),
  );
}
```

---

## 🎨 Step Components

### OnboardingStepOneContent

**Location:** `lib/features/onboarding/presentation/widgets/onboarding_step_one_content.dart`

**Structure:**
```
OnboardingStepOneContent
├── Image/Illustration
├── Title
├── Subtitle
├── Page Indicator
├── [Skip] Button
└── [Next] Button
```

**Parameters:**
```dart
OnboardingStepOneContent(
  onNext: () { },        // Called when Next is tapped
  onSkip: () { },        // Called when Skip is tapped
  currentPage: 0,        // Current page index
)
```

**Implementation Example:**
```dart
class OnboardingStepOneContent extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;
  final int currentPage;
  
  const OnboardingStepOneContent({
    required this.onNext,
    required this.onSkip,
    required this.currentPage,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Illustration
        Image.asset(AppAssets.onboarding1, height: 300.h),
        
        // Title
        Text(
          'Welcome',
          style: AppText.ibmHeading22(color: AppColors.dark),
          textAlign: TextAlign.center,
        ),
        
        // Description
        Text(
          'Discover amazing home services',
          style: AppText.ibmDescription14(color: AppColors.gray),
          textAlign: TextAlign.center,
        ),
        
        // Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                height: 8.h,
                width: currentPage == index ? 32.w : 8.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: currentPage == index
                      ? AppColors.greenPrimary
                      : AppColors.gray,
                ),
              ),
            ),
          ),
        ),
        
        // Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onSkip,
                child: const Text('Skip'),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: ElevatedButton(
                onPressed: onNext,
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
```

---

### OnboardingStepTwoContent

**Location:** `lib/features/onboarding/presentation/widgets/onboarding_step_two_content.dart`

**Structure:**
```
OnboardingStepTwoContent
├── Image/Illustration
├── Title
├── Subtitle
├── Features List
├── Page Indicator
└── [Start] Button
```

**Parameters:**
```dart
OnboardingStepTwoContent(
  onStart: () { },       // Called when Start is tapped
  currentPage: 1,        // Current page index
)
```

**Implementation Example:**
```dart
class OnboardingStepTwoContent extends StatelessWidget {
  final VoidCallback onStart;
  final int currentPage;
  
  const OnboardingStepTwoContent({
    required this.onStart,
    required this.currentPage,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Illustration
        Image.asset(AppAssets.onboarding2, height: 300.h),
        
        // Title
        Text(
          'Reliable Services',
          style: AppText.ibmHeading22(color: AppColors.dark),
          textAlign: TextAlign.center,
        ),
        
        // Description
        Text(
          'Get the best home services available',
          style: AppText.ibmDescription14(color: AppColors.gray),
          textAlign: TextAlign.center,
        ),
        
        // Features List
        Column(
          children: [
            _FeatureItem('Trusted Services'),
            _FeatureItem('Competitive Prices'),
            _FeatureItem('24/7 Support'),
          ],
        ),
        
        // Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Container(
                height: 8.h,
                width: currentPage == index ? 32.w : 8.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: currentPage == index
                      ? AppColors.greenPrimary
                      : AppColors.gray,
                ),
              ),
            ),
          ),
        ),
        
        // Start Button
        ElevatedButton(
          onPressed: onStart,
          child: const Text('Start Now'),
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;
  
  const _FeatureItem(this.text);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.greenPrimary,
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.white,
              size: 16,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            text,
            style: AppText.ibmDescription14(color: AppColors.dark),
          ),
        ],
      ),
    );
  }
}
```

---

## 🔄 Complete User Flow

```
┌─────────────────────────────────────┐
│  Splash Screen                      │
│  (8 seconds)                        │
│  CacheHelper.getData('onBoarding')  │
│  = null or false                   │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│  OnboardingScreen                   │
│  PageView.page = 0                  │
│  _currentPage = 0                   │
│  ┌─────────────────────────────────┐│
│  │ OnboardingStepOneContent        ││
│  │ [Skip]           [Next]         ││
│  └─────────────────────────────────┘│
└──────────┬─────────────┬────────────┘
           │             │
        Skip          Next
           │             │
           ↓             ↓
     ┌──────────┐   ┌─────────────────────────────────────┐
     │  Save    │   │  PageView.animateToPage(1)          │
     │  goto    │   │  _currentPage = 1                   │
     │  SignIn  │   │  setState(() => ...)                │
     └──────────┘   │  ┌─────────────────────────────────┐│
                    │  │ OnboardingStepTwoContent        ││
                    │  │                 [Start]         ││
                    │  └─────────────────────────────────┘│
                    └───────────────┬──────────────────────┘
                                    │
                               Start
                                    ↓
                    ┌──────────────────────────────┐
                    │ _finishOnboarding()          │
                    │ Save onBoarding = true       │
                    │ context.go(SignIn)           │
                    └──────────────────────────────┘
```

---

## 🎨 Design Standards

### Colors
```dart
// Main Text
AppColors.dark          // Black

// Secondary Text
AppColors.gray          // Gray

// Primary Button
AppColors.greenPrimary  // Green

// Background
AppColors.white         // White
```

### Spacing & Sizes
```dart
// Margins
EdgeInsets.symmetric(horizontal: 24.w)

// Spacing Between Elements
SizedBox(height: 32.h)

// Image Size
height: 300.h

// Button Height
height: 48.h
```

---

## 📝 Important Notes

### 1. Save State
```dart
// ✅ Correct: Save to cache
CacheHelper.saveData(key: 'onBoarding', value: true)

// ❌ Wrong: Don't save
// Onboarding will show every time
```

### 2. Handle Mounted State
```dart
// ✅ Correct: Check
if (!mounted) return;

// ❌ Wrong: No check
context.go(AppRouter.signIn);  // May cause error
```

### 3. Clean Resources
```dart
// ✅ Correct
@override
void dispose() {
  _pageController.dispose();
  super.dispose();
}

// ❌ Wrong: Don't clean
// Memory leak
```

---

## 🧪 Testing

### Navigation Test
```dart
testWidgets('Can navigate to next page', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Find next button
  final nextButton = find.byIcon(Icons.arrow_forward);
  
  // Tap it
  await tester.tap(nextButton);
  await tester.pumpAndSettle();
  
  // Verify second page
  expect(find.text('Reliable Services'), findsOneWidget);
});

testWidgets('Skip goes to Sign In', (WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Find skip button
  final skipButton = find.byIcon(Icons.close);
  
  // Tap it
  await tester.tap(skipButton);
  await tester.pumpAndSettle();
  
  // Verify navigation to SignIn
  expect(find.byType(SingIn), findsOneWidget);
});
```

---

## ✅ Checklist

- [ ] Steps display correctly
- [ ] Navigation between pages works
- [ ] Skip button functions properly
- [ ] Start button navigates to SignIn
- [ ] State saves in cache
- [ ] Page indicators show correctly
- [ ] PageController is cleaned up
- [ ] Mounted state is handled

---

**Last Updated:** 2024
**Version:** 1.0
