1. Overview
   This module handles the application's onboarding flow, language localization, and secure user entry points. It has been built with an emphasis on code reusability, responsiveness, and clear separation between the UI layout and business logic.

2. Included Screens & Features
   🌟 Initial Flows
   Splash Screen: The initial launch screen handled by an animated transition to maintain a premium native feel.

Onboarding Screens: A smooth page-view flow highlighting core app values, complete with dynamic page indicators and navigation handling.

🔐 Authentication Screens
Login Screen: Supports standard email and password input fields with complete input validation.

Sign-Up Screen: Enables users to register a new account with strict data validation.

OTP Verification Screen: A dedicated 4 or 6 digit input grid featuring automatic text-field focusing and a localized resend timer countdown.

🌐 Core Features
Language Switcher Widget: A custom toggle button/dropdown integrated globally. It changes the app localization on the fly (between Arabic and English) dynamically reflecting translation keys across all screens without needing an app restart.

3. Architecture & Folder Structure
   The project strictly separates the User Interface layout from the application state and business logic using a feature-first architectural pattern.

4. UI Implementation (Presentation Layer)
   To optimize layout building and minimize rendering costs, custom wrapper components were introduced:

Reusable TextFields: Standardized layout handling error messages, focus nodes, hidden password toggles, and localized helper text.

Custom Buttons: Adaptive loading configurations that automatically switch to a native CircularProgressIndicator during backend calls to block duplicate multi-tap submissions.

Responsive Layouts: Wrapped in scrollable views to handle smaller viewport screens and safely accommodate soft keyboards without overflow issues.

5. Business Logic & Data Handling
   🧠 State Management
   The UI interacts with the business logic safely through encapsulated state streams.

Asynchronous Flow: Triggers state transitions between Initial, Loading, Success, and Failure hooks.

Error Prevention: The UI layers only react to incoming states via decoupled listeners to issue routing redirects or present feedback snackbars, leaving the screens purely clean of logic code.

📁 Input Validation Rules
Email: Validated against standardized Regular Expressions (Regex).

Password: Checked against standard length requirements and character constraints.

OTP State: Restricts text entries exclusively to numeric values, tracks individual character indices, and maps automatic focus adjustments on entry completion.

🌍 Localization Engine
Dynamically Driven: Powered by translation lookup hooks map strings via reactive state blocks.

Persistent Preference: Safely saves user language selections, updating text alignment configurations and mirror direction layout behaviors locally for smooth Right-to-Left (RTL) and Left-to-Right (LTR) structural flows.

6. Self-Review & Clean Code Checklist
   Before pushing to production review, the following optimizations were applied:

[x] DRY Principle: All structural form items, dialog structures, and button configurations are abstracted to separate customizable widget trees.

[x] No Hardcoded Strings: Every visual element relies entirely on localized key mappings.

[x] Code Health: Removed all debugging lines (print statements, unneeded console logs) and removed unused package imports.

[x] Keyboard Safety: Checked layouts across edge devices to verify zero UI constraint pixel overflow behaviors.