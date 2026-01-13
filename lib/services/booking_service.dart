import '../models/booking_model.dart';
import '../models/flight_model.dart';
import '../models/passenger_model.dart';
import 'firestore_service.dart';

class BookingService {
  final FirestoreService _firestoreService = FirestoreService();

  // Create a new booking
  Future<BookingModel> createBooking({
    required String userId,
    required FlightModel flight,
    required List<PassengerModel> passengers,
    required List<String> seatNumbers,
    required double totalPrice,
  }) async {
    try {
      final booking = BookingModel(
        id: '', // Will be set by Firestore
        userId: userId,
        flightId: flight.id,
        bookingReference: BookingModel.generateBookingReference(),
        passengers: passengers,
        totalPrice: totalPrice,
        status: 'confirmed',
        paymentStatus: 'success',
        bookedAt: DateTime.now(),
        seatNumbers: seatNumbers,
        flightNumber: flight.flightNumber,
        airline: flight.airline,
        origin: flight.origin,
        destination: flight.destination,
        departureTime: flight.departureTime,
        arrivalTime: flight.arrivalTime,
      );

      final bookingId = await _firestoreService.createBooking(booking);
      return booking.copyWith(id: bookingId);
    } catch (e) {
      throw Exception('Failed to create booking: ${e.toString()}');
    }
  }

  // Get user bookings
  Future<List<BookingModel>> getUserBookings(String userId) async {
    try {
      return await _firestoreService.getUserBookings(userId);
    } catch (e) {
      throw Exception('Failed to get bookings: ${e.toString()}');
    }
  }

  // Get booking by ID
  Future<BookingModel?> getBooking(String bookingId) async {
    try {
      return await _firestoreService.getBooking(bookingId);
    } catch (e) {
      throw Exception('Failed to get booking: ${e.toString()}');
    }
  }

  // Cancel booking
  Future<void> cancelBooking(String bookingId) async {
    try {
      await _firestoreService.cancelBooking(bookingId);
    } catch (e) {
      throw Exception('Failed to cancel booking: ${e.toString()}');
    }
  }

  // Get upcoming bookings
  List<BookingModel> getUpcomingBookings(List<BookingModel> bookings) {
    return bookings.where((b) => b.isUpcoming).toList();
  }

  // Get past bookings
  List<BookingModel> getPastBookings(List<BookingModel> bookings) {
    return bookings
        .where((b) => b.isCompleted && !b.isCancelled)
        .toList();
  }

  // Get cancelled bookings
  List<BookingModel> getCancelledBookings(List<BookingModel> bookings) {
    return bookings.where((b) => b.isCancelled).toList();
  }

  // Calculate booking total
  double calculateBookingTotal({
    required double basePrice,
    required int passengers,
    double taxRate = 0.1,
    double serviceFee = 10.0,
  }) {
    final baseFare = basePrice * passengers;
    final taxes = baseFare * taxRate;
    final total = baseFare + taxes + serviceFee;
    return double.parse(total.toStringAsFixed(2));
  }

  // Get fare breakdown
  Map<String, double> getFareBreakdown({
    required double basePrice,
    required int passengers,
    double taxRate = 0.1,
    double serviceFee = 10.0,
    double discount = 0.0,
  }) {
    final baseFare = basePrice * passengers;
    final taxes = baseFare * taxRate;
    final subtotal = baseFare + taxes + serviceFee;
    final total = subtotal - discount;

    return {
      'baseFare': double.parse(baseFare.toStringAsFixed(2)),
      'taxes': double.parse(taxes.toStringAsFixed(2)),
      'serviceFee': serviceFee,
      'discount': discount,
      'subtotal': double.parse(subtotal.toStringAsFixed(2)),
      'total': double.parse(total.toStringAsFixed(2)),
    };
  }

  // Validate booking
  bool validateBooking({
    required List<PassengerModel> passengers,
    required List<String> seatNumbers,
  }) {
    // Check if all passengers have seats
    if (passengers.length != seatNumbers.length) {
      return false;
    }

    // Check if all passengers have required information
    for (final passenger in passengers) {
      if (passenger.firstName.isEmpty ||
          passenger.lastName.isEmpty ||
          passenger.email.isEmpty ||
          passenger.passportNumber.isEmpty) {
        return false;
      }
    }

    return true;
  }

  // Generate seat numbers (for testing)
  List<String> generateSeatNumbers(int count) {
    final seats = <String>[];
    final rows = ['A', 'B', 'C', 'D', 'E', 'F'];
    for (int i = 0; i < count; i++) {
      final row = (i ~/ 6) + 1;
      final seat = rows[i % 6];
      seats.add('$row$seat');
    }
    return seats;
  }
}
