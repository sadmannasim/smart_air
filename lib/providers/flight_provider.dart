import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import '../services/flight_service.dart';

class FlightProvider extends ChangeNotifier {
  final FlightService _flightService = FlightService();

  List<FlightModel> _flights = [];
  List<FlightModel> _filteredFlights = [];
  FlightModel? _selectedFlight;
  bool _isLoading = false;
  String? _error;

  // Search parameters
  String? _origin;
  String? _destination;
  DateTime? _departureDate;
  DateTime? _returnDate;
  int _passengers = 1;
  String _travelClass = 'Economy';
  bool _isRoundTrip = false;

  // Filters
  double? _maxPrice;
  int? _maxStops;
  List<String> _selectedAirlines = [];
  String _sortBy = 'price_low';

  // Getters
  List<FlightModel> get flights => _filteredFlights;
  FlightModel? get selectedFlight => _selectedFlight;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get origin => _origin;
  String? get destination => _destination;
  DateTime? get departureDate => _departureDate;
  DateTime? get returnDate => _returnDate;
  int get passengers => _passengers;
  String get travelClass => _travelClass;
  bool get isRoundTrip => _isRoundTrip;

  // Search flights
  Future<void> searchFlights({
    required String origin,
    required String destination,
    required DateTime departureDate,
    DateTime? returnDate,
    int passengers = 1,
    String travelClass = 'Economy',
    bool isRoundTrip = false,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      _origin = origin;
      _destination = destination;
      _departureDate = departureDate;
      _returnDate = returnDate;
      _passengers = passengers;
      _travelClass = travelClass;
      _isRoundTrip = isRoundTrip;
      notifyListeners();

      _flights = await _flightService.searchFlights(
        origin: origin,
        destination: destination,
        departureDate: departureDate,
        returnDate: returnDate,
        passengers: passengers,
        travelClass: travelClass,
        isRoundTrip: isRoundTrip,
      );

      _applyFiltersAndSort();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Load all flights
  Future<void> loadAllFlights() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _flights = await _flightService.getAllFlights();
      _applyFiltersAndSort();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Get flight details
  Future<void> getFlightDetails(String flightId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _selectedFlight = await _flightService.getFlightDetails(flightId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Select flight
  void selectFlight(FlightModel flight) {
    _selectedFlight = flight;
    notifyListeners();
  }

  // Apply filters
  void applyFilters({
    double? maxPrice,
    int? maxStops,
    List<String>? airlines,
  }) {
    _maxPrice = maxPrice;
    _maxStops = maxStops;
    _selectedAirlines = airlines ?? [];
    _applyFiltersAndSort();
    notifyListeners();
  }

  // Sort flights
  void sortFlights(String sortBy) {
    _sortBy = sortBy;
    _applyFiltersAndSort();
    notifyListeners();
  }

  // Apply filters and sorting
  void _applyFiltersAndSort() {
    // First apply filters
    _filteredFlights = _flightService.filterFlights(
      _flights,
      maxPrice: _maxPrice,
      maxStops: _maxStops,
      airlines: _selectedAirlines.isNotEmpty ? _selectedAirlines : null,
    );

    // Then apply sorting
    _filteredFlights = _flightService.sortFlights(_filteredFlights, _sortBy);
  }

  // Clear filters
  void clearFilters() {
    _maxPrice = null;
    _maxStops = null;
    _selectedAirlines = [];
    _applyFiltersAndSort();
    notifyListeners();
  }

  // Get available airlines
  List<String> getAvailableAirlines() {
    return _flightService.getAvailableAirlines(_flights);
  }

  // Get price range
  Map<String, double> getPriceRange() {
    return _flightService.getPriceRange(_flights);
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Reset search
  void resetSearch() {
    _flights = [];
    _filteredFlights = [];
    _selectedFlight = null;
    _origin = null;
    _destination = null;
    _departureDate = null;
    _returnDate = null;
    _passengers = 1;
    _travelClass = 'Economy';
    _isRoundTrip = false;
    clearFilters();
    notifyListeners();
  }
}
