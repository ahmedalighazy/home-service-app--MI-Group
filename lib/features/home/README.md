# Home Feature - Clean Architecture

## 📁 Structure

```
home/
├── presentation/
│   ├── pages/
│   │   └── home_page.dart          # Main home page with navigation
│   └── widgets/
│       ├── home_cotent.dart        # Main home content widget
│       ├── home_app_bar.dart       # Custom app bar with location & notification
│       ├── home_search_field.dart  # Search input field
│       ├── promo_banner_card.dart  # Promotional banner (Frame 2147225600.png)
│       ├── service_category_card.dart # Service category cards
│       ├── service_card.dart       # Service item cards
│       └── special_offer_banner.dart  # Special offer banner (Gemini_Generated_Image)
```

## 🎨 Design Implementation

### Phase 1: Header Section
- Gradient background (cyan colors)
- App bar with:
  - Notification bell (with red dot indicator)
  - Location dropdown
  - User avatar
- Search bar with rounded design

### Phase 2: Promo Banner
- Image: `Frame 2147225600.png`
- Shows cleaning service promotion
- Displays price (120 SAR)
- Promo code badge (CLEAN15)

### Phase 3: Service Categories
- 4 main categories with icons:
  - تنظيف منزل عميق (Deep Home Cleaning)
  - تنظيف منزل (Home Cleaning)
  - خدمات مكافحة الحشرات (Pest Control)
  - خدمات المؤسسات (Institution Services)

### Phase 4: Popular Services
- Horizontal scrollable list
- Service cards with:
  - Service image
  - Discount badges
  - "New" badges
  - Arrow button for details

### Phase 5: Special Offer Banner
- Image: `Gemini_Generated_Image_oom6zkoom6zkoom6 12.png`
- Companies & institutions offers
- "Book Now" button
- 24-hour service indicator

## 🎯 Clean Architecture Principles

### Core Layer
- `lib/core/models/` - Data models (ServiceCategory, ServiceItem)
- `lib/core/themes/` - Text styles and colors
- `lib/core/widgets/` - Reusable widgets (GradientHeader)
- `lib/core/constants/` - App strings and sizes

### Feature Layer
- Separated widgets for each UI component
- Single responsibility principle
- Reusable and testable components

## 🚀 Usage

```dart
import 'package:home_service_app/features/home/presentation/pages/home_page.dart';

// Navigate to home page
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const HomePage()),
);
```

## 📸 Required Assets

Make sure these images exist in `assets/images/`:
- Frame 2147225600.png (Promo banner)
- Gemini_Generated_Image_oom6zkoom6zkoom6 12.png (Special offer)
- Rectangle 45.png (Service card)
- ChatGPT Image Apr 30, 2026, 07_04_20 PM 1.png (Service card)
- Gemini_Generated_Image_easzy8easzy8easz 1.png (Service card)
- Topographic 7.png (User avatar)

## 🎨 Icons

Using `iconsax_flutter` package for modern icons:
- `Iconsax.home_copy` - Home icon
- `Iconsax.calendar_copy` - Calendar icon
- `Iconsax.user_copy` - User icon
- `Iconsax.notification_copy` - Notification icon
- `Iconsax.location_copy` - Location icon
- `Iconsax.search_normal_1_copy` - Search icon
- `Iconsax.building_copy` - Building icon
- `Iconsax.broom_copy` - Cleaning icon
- `Iconsax.security_safe_copy` - Security icon

## 📱 Features

- ✅ RTL (Right-to-Left) support for Arabic
- ✅ Responsive design with flutter_screenutil
- ✅ Bottom navigation with custom design
- ✅ Smooth scrolling with CustomScrollView
- ✅ Reusable widgets
- ✅ Clean code structure
- ✅ Type-safe models
