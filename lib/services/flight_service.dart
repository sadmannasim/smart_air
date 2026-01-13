import '../models/flight_model.dart';
import 'firestore_service.dart';

class FlightService {
  final FirestoreService _firestoreService = FirestoreService();

  // Search flights with filters
  Future<List<FlightModel>> searchFlights({
    required String origin,
    required String destination,
    required DateTime departureDate,
    DateTime? returnDate,
    int passengers = 1,
    String travelClass = 'Economy',
    bool isRoundTrip = false,
  }) async {
    try {
      final flights = await _firestoreService.searchFlights(
        origin: origin,
        destination: destination,
        departureDate: departureDate,
        travelClass: travelClass,
      );

      return flights;
    } catch (e) {
      throw Exception('Failed to search flights: ${e.toString()}');
    }
  }

  // Get all flights
  Future<List<FlightModel>> getAllFlights() async {
    try {
      return await _firestoreService.getAllFlights();
    } catch (e) {
      throw Exception('Failed to get flights: ${e.toString()}');
    }
  }

  // Get flight details
  Future<FlightModel?> getFlightDetails(String flightId) async {
    try {
      return await _firestoreService.getFlight(flightId);
    } catch (e) {
      throw Exception('Failed to get flight details: ${e.toString()}');
    }
  }

  // Filter flights
  List<FlightModel> filterFlights(
    List<FlightModel> flights, {
    double? maxPrice,
    int? maxStops,
    List<String>? airlines,
  }) {
    var filteredFlights = flights;

    if (maxPrice != null) {
      filteredFlights =
          filteredFlights.where((f) => f.price <= maxPrice).toList();
    }

    if (maxStops != null) {
      filteredFlights =
          filteredFlights.where((f) => f.stops <= maxStops).toList();
    }

    if (airlines != null && airlines.isNotEmpty) {
      filteredFlights =
          filteredFlights.where((f) => airlines.contains(f.airline)).toList();
    }

    return filteredFlights;
  }

  // Sort flights
  List<FlightModel> sortFlights(
    List<FlightModel> flights,
    String sortBy,
  ) {
    final sortedFlights = List<FlightModel>.from(flights);

    switch (sortBy) {
      case 'price_low':
        sortedFlights.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        sortedFlights.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'duration':
        sortedFlights.sort((a, b) => a.duration.compareTo(b.duration));
        break;
      case 'departure':
        sortedFlights.sort((a, b) => a.departureTime.compareTo(b.departureTime));
        break;
      case 'arrival':
        sortedFlights.sort((a, b) => a.arrivalTime.compareTo(b.arrivalTime));
        break;
      default:
        // Default sort by price
        sortedFlights.sort((a, b) => a.price.compareTo(b.price));
    }

    return sortedFlights;
  }

  // Get available airlines from flights
  List<String> getAvailableAirlines(List<FlightModel> flights) {
    final airlines = flights.map((f) => f.airline).toSet().toList();
    airlines.sort();
    return airlines;
  }

  // Get price range
  Map<String, double> getPriceRange(List<FlightModel> flights) {
    if (flights.isEmpty) {
      return {'min': 0, 'max': 0};
    }

    final prices = flights.map((f) => f.price).toList();
    return {
      'min': prices.reduce((a, b) => a < b ? a : b),
      'max': prices.reduce((a, b) => a > b ? a : b),
    };
  }

  // Check seat availability
  bool checkSeatAvailability(FlightModel flight, int requestedSeats) {
    return flight.seatsAvailable >= requestedSeats;
  }

  // Calculate total price
  double calculateTotalPrice(FlightModel flight, int passengers) {
    return flight.price * passengers;
  }
}
