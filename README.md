# Smart Air ✈️

Professional Air Ticketing Mobile Application built with Flutter & Firebase

## 📱 Project Overview

Smart Air is a complete, production-ready air ticketing mobile application that provides users with a seamless flight booking experience. Built with Flutter for cross-platform compatibility and Firebase for backend services.

## ✨ Features

### Authentication & User Management
- ✅ Email/Password Registration & Login
- ✅ Google Sign-In Integration
- ✅ Password Reset/Forgot Password
- ✅ Session Persistence
- ✅ User Profile Management

### Flight Search & Booking
- ✅ Flight Search with Filters (Origin, Destination, Date, Class)
- ✅ One-way and Round-trip Options
- ✅ Passenger Selection (Adults, Children, Infants)
- ✅ Travel Class Selection (Economy, Business, First Class)
- ✅ Flight Results with Sorting & Filtering
- ✅ Detailed Flight Information
- ✅ Seat Selection Interface
- ✅ Passenger Details Form
- ✅ Payment Processing UI
- ✅ Booking Confirmation with E-Ticket

### Bookings & Tickets
- ✅ My Bookings (Upcoming, Past, Cancelled)
- ✅ Digital E-Ticket with QR Code
- ✅ Booking History
- ✅ Booking Management

### Additional Features
- ✅ Featured Destinations
- ✅ Special Offers
- ✅ Push Notifications (FCM)
- ✅ Dark Mode Support
- ✅ Responsive Design
- ✅ Professional UI/UX

## 🛠 Technology Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Firebase
- **Database:** Cloud Firestore
- **Authentication:** Firebase Auth
- **Notifications:** Firebase Cloud Messaging
- **State Management:** Provider
- **UI:** Material Design 3

## 📦 Dependencies

```yaml
- flutter (SDK)
- firebase_core ^2.24.2
- firebase_auth ^4.16.0
- cloud_firestore ^4.14.0
- firebase_messaging ^14.7.10
- provider ^6.1.1
- google_sign_in ^6.2.1
- intl ^0.18.1
- qr_flutter ^4.1.0
- flutter_svg ^2.0.9
- cached_network_image ^3.3.1
- shimmer ^3.0.0
- google_fonts ^6.1.0
- flutter_local_notifications ^16.3.0
- share_plus ^7.2.1
- pdf ^3.10.7
- path_provider ^2.1.1
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Firebase Account
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/sadmannasim/smart_air.git
   cd smart_air
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   a. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   
   b. Add your Android/iOS apps to the project
   
   c. Download configuration files:
      - `google-services.json` for Android (place in `android/app/`)
      - `GoogleService-Info.plist` for iOS (place in `ios/Runner/`)
   
   d. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```
   
   e. Configure Firebase:
   ```bash
   flutterfire configure
   ```
   This will generate `lib/firebase_options.dart` with your actual configuration.

4. **Enable Firebase Services**

   In your Firebase Console, enable:
   - Authentication (Email/Password and Google Sign-In)
   - Cloud Firestore
   - Firebase Cloud Messaging
   
5. **Deploy Firestore Rules and Indexes**
   ```bash
   firebase deploy --only firestore:rules
   firebase deploy --only firestore:indexes
   ```

6. **Setup Google Sign-In**

   a. In Firebase Console > Authentication > Sign-in method, enable Google
   
   b. For Android: Add SHA-1 and SHA-256 fingerprints in Firebase project settings
   ```bash
   cd android
   ./gradlew signingReport
   ```
   
   c. For iOS: Add the reversed client ID to `ios/Runner/Info.plist`

### Running the App

```bash
# Run on connected device/emulator
flutter run

# Run in release mode
flutter run --release

# Build APK (Android)
flutter build apk --release

# Build IPA (iOS)
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── main.dart                  # App entry point
├── firebase_options.dart      # Firebase configuration
├── config/
│   ├── theme.dart            # App theme (light & dark)
│   ├── constants.dart        # App constants
│   └── routes.dart           # Navigation routes
├── models/
│   ├── user_model.dart       # User data model
│   ├── flight_model.dart     # Flight data model
│   ├── booking_model.dart    # Booking data model
│   ├── passenger_model.dart  # Passenger data model
│   └── airport_model.dart    # Airport data model
├── services/
│   ├── auth_service.dart     # Authentication service
│   ├── firestore_service.dart # Database operations
│   ├── flight_service.dart   # Flight operations
│   ├── booking_service.dart  # Booking operations
│   └── notification_service.dart # Push notifications
├── providers/
│   ├── auth_provider.dart    # Auth state management
│   ├── flight_provider.dart  # Flight state management
│   ├── booking_provider.dart # Booking state management
│   └── user_provider.dart    # User state management
├── screens/
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── auth/                 # Authentication screens
│   ├── home/                 # Home & navigation
│   ├── search/               # Search screens
│   ├── flights/              # Flight listing & details
│   ├── booking/              # Booking flow
│   ├── my_bookings/          # Bookings & tickets
│   └── profile/              # User profile
├── widgets/
│   ├── common/               # Reusable widgets
│   ├── flight_card.dart
│   ├── booking_card.dart
│   ├── airport_tile.dart
│   └── ticket_widget.dart
└── utils/
    ├── validators.dart       # Form validators
    ├── date_formatter.dart   # Date formatting
    └── helpers.dart          # Helper functions
```

## 🗄 Firestore Database Structure

### Collections

#### `users/`
```json
{
  "email": "string",
  "displayName": "string",
  "photoUrl": "string",
  "phoneNumber": "string",
  "createdAt": "timestamp",
  "savedTravelers": []
}
```

#### `flights/`
```json
{
  "flightNumber": "string",
  "airline": "string",
  "origin": "string",
  "destination": "string",
  "departureTime": "timestamp",
  "arrivalTime": "timestamp",
  "duration": "number",
  "stops": "number",
  "price": "number",
  "seatsAvailable": "number",
  "travelClass": "string"
}
```

#### `bookings/`
```json
{
  "userId": "string",
  "flightId": "string",
  "bookingReference": "string",
  "passengers": [],
  "totalPrice": "number",
  "status": "string",
  "paymentStatus": "string",
  "bookedAt": "timestamp",
  "seatNumbers": []
}
```

#### `airports/`
```json
{
  "code": "string",
  "name": "string",
  "city": "string",
  "country": "string",
  "searchTerms": []
}
```

## 🎨 Design & UI

- **Color Scheme:** 
  - Primary: Deep Blue (#1A73E8)
  - Accent: Orange (#FF6B35)
- **Typography:** Google Fonts (Poppins)
- **Design System:** Material Design 3
- **Dark Mode:** Full support

## 🔒 Security

- Firestore security rules implemented
- Authentication required for all operations
- User data protection
- Secure payment processing UI

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (iOS 12+)

## 🧪 Testing

```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test
```

## 🚢 Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
# Then archive in Xcode
```

## 📝 License

This project is licensed under the MIT License.

## 👨‍💻 Author

**Sadman Nasim**
- GitHub: [@sadmannasim](https://github.com/sadmannasim)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## ⭐ Show your support

Give a ⭐️ if this project helped you!

## 📞 Support

For support, email sadmannasim@example.com or create an issue in the repository.

---

**Note:** This is a complete, production-ready Flutter application. Make sure to configure Firebase properly before running the app. Sample data seeding scripts and additional features can be added as needed.
