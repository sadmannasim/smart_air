class AppConstants {
  // App Info
  static const String appName = 'Smart Air';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your Gateway to the Skies';
  
  // API Endpoints (if needed for external services)
  static const String baseUrl = 'https://api.smartair.com';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String flightsCollection = 'flights';
  static const String bookingsCollection = 'bookings';
  static const String airportsCollection = 'airports';
  
  // Shared Preferences Keys
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyUserId = 'userId';
  static const String keyUserEmail = 'userEmail';
  static const String keyThemeMode = 'themeMode';
  static const String keyOnboardingComplete = 'onboardingComplete';
  
  // Pagination
  static const int flightsPerPage = 20;
  static const int bookingsPerPage = 10;
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxPassengerCount = 9;
  static const int minPassengerAge = 0;
  static const int maxPassengerAge = 120;
  
  // Travel Classes
  static const List<String> travelClasses = [
    'Economy',
    'Premium Economy',
    'Business',
    'First Class',
  ];
  
  // Passenger Types
  static const List<String> passengerTypes = [
    'Adult (12+ years)',
    'Child (2-11 years)',
    'Infant (0-2 years)',
  ];
  
  // Booking Status
  static const String statusPending = 'pending';
  static const String statusConfirmed = 'confirmed';
  static const String statusCompleted = 'completed';
  static const String statusCancelled = 'cancelled';
  
  // Payment Status
  static const String paymentPending = 'pending';
  static const String paymentSuccess = 'success';
  static const String paymentFailed = 'failed';
  
  // Date Formats
  static const String dateFormat = 'dd MMM yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd MMM yyyy, HH:mm';
  static const String fullDateFormat = 'EEEE, dd MMMM yyyy';
  
  // Currency
  static const String currencySymbol = '\$';
  static const String currencyCode = 'USD';
  
  // Error Messages
  static const String errorGeneral = 'Something went wrong. Please try again.';
  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorNoFlights = 'No flights found for your search.';
  static const String errorNoBookings = 'You have no bookings yet.';
  static const String errorInvalidEmail = 'Please enter a valid email address.';
  static const String errorInvalidPassword = 'Password must be at least 6 characters.';
  static const String errorFieldRequired = 'This field is required.';
  
  // Success Messages
  static const String successRegistration = 'Account created successfully!';
  static const String successLogin = 'Welcome back!';
  static const String successBooking = 'Booking confirmed successfully!';
  static const String successProfileUpdate = 'Profile updated successfully!';
  static const String successPasswordReset = 'Password reset email sent!';
  
  // Sample Airlines
  static const List<Map<String, String>> sampleAirlines = [
    {'name': 'Sky Airlines', 'code': 'SA'},
    {'name': 'Air Global', 'code': 'AG'},
    {'name': 'Swift Airways', 'code': 'SW'},
    {'name': 'Blue Sky', 'code': 'BS'},
    {'name': 'Global Express', 'code': 'GX'},
    {'name': 'Pacific Air', 'code': 'PA'},
    {'name': 'Atlantic Wings', 'code': 'AW'},
    {'name': 'Continental Jet', 'code': 'CJ'},
  ];
  
  // Sample Destinations
  static const List<Map<String, String>> featuredDestinations = [
    {'city': 'Paris', 'country': 'France', 'image': 'paris.jpg'},
    {'city': 'New York', 'country': 'USA', 'image': 'newyork.jpg'},
    {'city': 'Tokyo', 'country': 'Japan', 'image': 'tokyo.jpg'},
    {'city': 'Dubai', 'country': 'UAE', 'image': 'dubai.jpg'},
    {'city': 'London', 'country': 'UK', 'image': 'london.jpg'},
    {'city': 'Singapore', 'country': 'Singapore', 'image': 'singapore.jpg'},
  ];
  
  // Seat Configuration
  static const int seatsPerRow = 6;
  static const List<String> seatColumns = ['A', 'B', 'C', 'D', 'E', 'F'];
  static const int totalRows = 30;
  
  // Baggage Allowance
  static const Map<String, Map<String, String>> baggageAllowance = {
    'Economy': {
      'cabin': '7 kg',
      'checkedIn': '20 kg',
    },
    'Premium Economy': {
      'cabin': '10 kg',
      'checkedIn': '25 kg',
    },
    'Business': {
      'cabin': '14 kg',
      'checkedIn': '30 kg',
    },
    'First Class': {
      'cabin': '14 kg',
      'checkedIn': '40 kg',
    },
  };
  
  // Onboarding
  static const List<Map<String, String>> onboardingData = [
    {
      'title': 'Search & Compare',
      'description': 'Find the best flight deals from hundreds of airlines',
      'image': 'onboarding1.png',
    },
    {
      'title': 'Book with Ease',
      'description': 'Simple and secure booking process in just a few taps',
      'image': 'onboarding2.png',
    },
    {
      'title': 'Travel Smart',
      'description': 'Get instant e-tickets and manage your bookings easily',
      'image': 'onboarding3.png',
    },
  ];
}
