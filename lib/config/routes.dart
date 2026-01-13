import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/home/main_navigation.dart';
import '../screens/home/home_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/search/airport_search_screen.dart';
import '../screens/flights/flight_results_screen.dart';
import '../screens/flights/flight_details_screen.dart';
import '../screens/booking/passenger_details_screen.dart';
import '../screens/booking/seat_selection_screen.dart';
import '../screens/booking/payment_screen.dart';
import '../screens/booking/booking_confirmation_screen.dart';
import '../screens/my_bookings/my_bookings_screen.dart';
import '../screens/my_bookings/ticket_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/edit_profile_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String mainNavigation = '/main';
  static const String home = '/home';
  static const String search = '/search';
  static const String airportSearch = '/airport-search';
  static const String flightResults = '/flight-results';
  static const String flightDetails = '/flight-details';
  static const String passengerDetails = '/passenger-details';
  static const String seatSelection = '/seat-selection';
  static const String payment = '/payment';
  static const String bookingConfirmation = '/booking-confirmation';
  static const String myBookings = '/my-bookings';
  static const String ticket = '/ticket';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      
      case mainNavigation:
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
      case search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      
      case airportSearch:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => AirportSearchScreen(
            isOrigin: args?['isOrigin'] ?? true,
          ),
        );
      
      case flightResults:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FlightResultsScreen(
            searchParams: args,
          ),
        );
      
      case flightDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => FlightDetailsScreen(
            flight: args['flight'],
          ),
        );
      
      case passengerDetails:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PassengerDetailsScreen(
            flight: args['flight'],
            passengers: args['passengers'],
          ),
        );
      
      case seatSelection:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SeatSelectionScreen(
            flight: args['flight'],
            passengers: args['passengers'],
          ),
        );
      
      case payment:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            flight: args['flight'],
            passengers: args['passengers'],
            seats: args['seats'],
          ),
        );
      
      case bookingConfirmation:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BookingConfirmationScreen(
            booking: args['booking'],
          ),
        );
      
      case myBookings:
        return MaterialPageRoute(builder: (_) => const MyBookingsScreen());
      
      case ticket:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => TicketScreen(
            booking: args['booking'],
          ),
        );
      
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
