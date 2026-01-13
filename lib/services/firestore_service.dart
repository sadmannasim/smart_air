import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/flight_model.dart';
import '../models/booking_model.dart';
import '../models/airport_model.dart';
import '../config/constants.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== USER OPERATIONS ====================

  // Create user document
  Future<void> createUser(UserModel user) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.id)
          .set(user.toMap());
    } catch (e) {
      throw Exception('Failed to create user: ${e.toString()}');
    }
  }

  // Get user document
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();

      if (doc.exists) {
        return UserModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get user: ${e.toString()}');
    }
  }

  // Update user document
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .update(data);
    } catch (e) {
      throw Exception('Failed to update user: ${e.toString()}');
    }
  }

  // Delete user document
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete user: ${e.toString()}');
    }
  }

  // Check if user exists
  Future<bool> userExists(String userId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  // ==================== FLIGHT OPERATIONS ====================

  // Get all flights
  Future<List<FlightModel>> getAllFlights() async {
    try {
      final querySnapshot =
          await _firestore.collection(AppConstants.flightsCollection).get();

      return querySnapshot.docs
          .map((doc) => FlightModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get flights: ${e.toString()}');
    }
  }

  // Search flights
  Future<List<FlightModel>> searchFlights({
    required String origin,
    required String destination,
    required DateTime departureDate,
    String? travelClass,
  }) async {
    try {
      Query query = _firestore
          .collection(AppConstants.flightsCollection)
          .where('origin', isEqualTo: origin)
          .where('destination', isEqualTo: destination);

      if (travelClass != null && travelClass.isNotEmpty) {
        query = query.where('travelClass', isEqualTo: travelClass);
      }

      final querySnapshot = await query.get();

      // Filter by departure date (same day)
      final flights = querySnapshot.docs
          .map((doc) => FlightModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .where((flight) {
        final flightDate = flight.departureTime;
        return flightDate.year == departureDate.year &&
            flightDate.month == departureDate.month &&
            flightDate.day == departureDate.day;
      }).toList();

      return flights;
    } catch (e) {
      throw Exception('Failed to search flights: ${e.toString()}');
    }
  }

  // Get flight by ID
  Future<FlightModel?> getFlight(String flightId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.flightsCollection)
          .doc(flightId)
          .get();

      if (doc.exists) {
        return FlightModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get flight: ${e.toString()}');
    }
  }

  // Add flight (for seeding data)
  Future<void> addFlight(FlightModel flight) async {
    try {
      await _firestore
          .collection(AppConstants.flightsCollection)
          .doc(flight.id)
          .set(flight.toMap());
    } catch (e) {
      throw Exception('Failed to add flight: ${e.toString()}');
    }
  }

  // ==================== BOOKING OPERATIONS ====================

  // Create booking
  Future<String> createBooking(BookingModel booking) async {
    try {
      final docRef = await _firestore
          .collection(AppConstants.bookingsCollection)
          .add(booking.toMap());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create booking: ${e.toString()}');
    }
  }

  // Get user bookings
  Future<List<BookingModel>> getUserBookings(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection(AppConstants.bookingsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('bookedAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get bookings: ${e.toString()}');
    }
  }

  // Get booking by ID
  Future<BookingModel?> getBooking(String bookingId) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.bookingsCollection)
          .doc(bookingId)
          .get();

      if (doc.exists) {
        return BookingModel.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get booking: ${e.toString()}');
    }
  }

  // Update booking status
  Future<void> updateBookingStatus(String bookingId, String status) async {
    try {
      await _firestore
          .collection(AppConstants.bookingsCollection)
          .doc(bookingId)
          .update({'status': status});
    } catch (e) {
      throw Exception('Failed to update booking: ${e.toString()}');
    }
  }

  // Cancel booking
  Future<void> cancelBooking(String bookingId) async {
    try {
      await _firestore
          .collection(AppConstants.bookingsCollection)
          .doc(bookingId)
          .update({
        'status': AppConstants.statusCancelled,
      });
    } catch (e) {
      throw Exception('Failed to cancel booking: ${e.toString()}');
    }
  }

  // ==================== AIRPORT OPERATIONS ====================

  // Get all airports
  Future<List<AirportModel>> getAllAirports() async {
    try {
      final querySnapshot =
          await _firestore.collection(AppConstants.airportsCollection).get();

      return querySnapshot.docs
          .map((doc) => AirportModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to get airports: ${e.toString()}');
    }
  }

  // Search airports
  Future<List<AirportModel>> searchAirports(String query) async {
    try {
      final querySnapshot =
          await _firestore.collection(AppConstants.airportsCollection).get();

      final airports = querySnapshot.docs
          .map((doc) => AirportModel.fromMap(doc.data(), doc.id))
          .toList();

      // Filter airports based on query
      final lowerQuery = query.toLowerCase();
      return airports.where((airport) {
        return airport.city.toLowerCase().contains(lowerQuery) ||
            airport.code.toLowerCase().contains(lowerQuery) ||
            airport.name.toLowerCase().contains(lowerQuery) ||
            airport.country.toLowerCase().contains(lowerQuery);
      }).toList();
    } catch (e) {
      throw Exception('Failed to search airports: ${e.toString()}');
    }
  }

  // Add airport (for seeding data)
  Future<void> addAirport(AirportModel airport) async {
    try {
      await _firestore
          .collection(AppConstants.airportsCollection)
          .doc(airport.id)
          .set(airport.toMap());
    } catch (e) {
      throw Exception('Failed to add airport: ${e.toString()}');
    }
  }

  // ==================== BATCH OPERATIONS ====================

  // Seed sample airports
  Future<void> seedAirports(List<AirportModel> airports) async {
    try {
      final batch = _firestore.batch();
      for (final airport in airports) {
        final docRef = _firestore
            .collection(AppConstants.airportsCollection)
            .doc(airport.id);
        batch.set(docRef, airport.toMap());
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to seed airports: ${e.toString()}');
    }
  }

  // Seed sample flights
  Future<void> seedFlights(List<FlightModel> flights) async {
    try {
      final batch = _firestore.batch();
      for (final flight in flights) {
        final docRef =
            _firestore.collection(AppConstants.flightsCollection).doc(flight.id);
        batch.set(docRef, flight.toMap());
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to seed flights: ${e.toString()}');
    }
  }
}
