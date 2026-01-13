import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../models/flight_model.dart';
import '../models/passenger_model.dart';
import '../services/booking_service.dart';

class BookingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  List<BookingModel> _bookings = [];
  BookingModel? _currentBooking;
  bool _isLoading = false;
  String? _error;

  // Booking process state
  List<PassengerModel> _passengers = [];
  List<String> _selectedSeats = [];
  double _totalPrice = 0.0;

  // Getters
  List<BookingModel> get bookings => _bookings;
  BookingModel? get currentBooking => _currentBooking;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<PassengerModel> get passengers => _passengers;
  List<String> get selectedSeats => _selectedSeats;
  double get totalPrice => _totalPrice;

  // Get upcoming bookings
  List<BookingModel> get upcomingBookings =>
      _bookingService.getUpcomingBookings(_bookings);

  // Get past bookings
  List<BookingModel> get pastBookings =>
      _bookingService.getPastBookings(_bookings);

  // Get cancelled bookings
  List<BookingModel> get cancelledBookings =>
      _bookingService.getCancelledBookings(_bookings);

  // Load user bookings
  Future<void> loadUserBookings(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _bookings = await _bookingService.getUserBookings(userId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Create booking
  Future<bool> createBooking({
    required String userId,
    required FlightModel flight,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Validate booking
      if (!_bookingService.validateBooking(
        passengers: _passengers,
        seatNumbers: _selectedSeats,
      )) {
        _error = 'Invalid booking information';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Create booking
      _currentBooking = await _bookingService.createBooking(
        userId: userId,
        flight: flight,
        passengers: _passengers,
        seatNumbers: _selectedSeats,
        totalPrice: _totalPrice,
      );

      // Add to bookings list
      _bookings.insert(0, _currentBooking!);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Get booking by ID
  Future<void> getBooking(String bookingId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _currentBooking = await _bookingService.getBooking(bookingId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Cancel booking
  Future<bool> cancelBooking(String bookingId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _bookingService.cancelBooking(bookingId);

      // Update local booking status
      final index = _bookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        _bookings[index] = _bookings[index].copyWith(status: 'cancelled');
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Add passenger
  void addPassenger(PassengerModel passenger) {
    _passengers.add(passenger);
    notifyListeners();
  }

  // Update passenger
  void updatePassenger(int index, PassengerModel passenger) {
    if (index >= 0 && index < _passengers.length) {
      _passengers[index] = passenger;
      notifyListeners();
    }
  }

  // Remove passenger
  void removePassenger(int index) {
    if (index >= 0 && index < _passengers.length) {
      _passengers.removeAt(index);
      notifyListeners();
    }
  }

  // Set passengers
  void setPassengers(List<PassengerModel> passengers) {
    _passengers = passengers;
    notifyListeners();
  }

  // Select seat
  void selectSeat(String seatNumber) {
    if (!_selectedSeats.contains(seatNumber)) {
      _selectedSeats.add(seatNumber);
      notifyListeners();
    }
  }

  // Deselect seat
  void deselectSeat(String seatNumber) {
    _selectedSeats.remove(seatNumber);
    notifyListeners();
  }

  // Set selected seats
  void setSelectedSeats(List<String> seats) {
    _selectedSeats = seats;
    notifyListeners();
  }

  // Calculate total price
  void calculateTotalPrice({
    required double basePrice,
    required int passengerCount,
  }) {
    _totalPrice = _bookingService.calculateBookingTotal(
      basePrice: basePrice,
      passengers: passengerCount,
    );
    notifyListeners();
  }

  // Get fare breakdown
  Map<String, double> getFareBreakdown(double basePrice, int passengerCount) {
    return _bookingService.getFareBreakdown(
      basePrice: basePrice,
      passengers: passengerCount,
    );
  }

  // Set current booking
  void setCurrentBooking(BookingModel booking) {
    _currentBooking = booking;
    notifyListeners();
  }

  // Clear booking process
  void clearBookingProcess() {
    _passengers = [];
    _selectedSeats = [];
    _totalPrice = 0.0;
    _currentBooking = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
