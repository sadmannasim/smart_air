import 'package:cloud_firestore/cloud_firestore.dart';

class FlightModel {
  final String id;
  final String flightNumber;
  final String airline;
  final String airlineLogo;
  final String origin;
  final String originCity;
  final String destination;
  final String destinationCity;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int duration; // in minutes
  final int stops;
  final double price;
  final int seatsAvailable;
  final String aircraft;
  final List<String> amenities;
  final String travelClass;

  FlightModel({
    required this.id,
    required this.flightNumber,
    required this.airline,
    required this.airlineLogo,
    required this.origin,
    required this.originCity,
    required this.destination,
    required this.destinationCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
    required this.price,
    required this.seatsAvailable,
    required this.aircraft,
    required this.amenities,
    this.travelClass = 'Economy',
  });

  // Convert FlightModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'flightNumber': flightNumber,
      'airline': airline,
      'airlineLogo': airlineLogo,
      'origin': origin,
      'originCity': originCity,
      'destination': destination,
      'destinationCity': destinationCity,
      'departureTime': Timestamp.fromDate(departureTime),
      'arrivalTime': Timestamp.fromDate(arrivalTime),
      'duration': duration,
      'stops': stops,
      'price': price,
      'seatsAvailable': seatsAvailable,
      'aircraft': aircraft,
      'amenities': amenities,
      'travelClass': travelClass,
    };
  }

  // Create FlightModel from Firestore document
  factory FlightModel.fromMap(Map<String, dynamic> map, String id) {
    return FlightModel(
      id: id,
      flightNumber: map['flightNumber'] ?? '',
      airline: map['airline'] ?? '',
      airlineLogo: map['airlineLogo'] ?? '',
      origin: map['origin'] ?? '',
      originCity: map['originCity'] ?? '',
      destination: map['destination'] ?? '',
      destinationCity: map['destinationCity'] ?? '',
      departureTime: (map['departureTime'] as Timestamp).toDate(),
      arrivalTime: (map['arrivalTime'] as Timestamp).toDate(),
      duration: map['duration'] ?? 0,
      stops: map['stops'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      seatsAvailable: map['seatsAvailable'] ?? 0,
      aircraft: map['aircraft'] ?? '',
      amenities: List<String>.from(map['amenities'] ?? []),
      travelClass: map['travelClass'] ?? 'Economy',
    );
  }

  // Get formatted duration (e.g., "2h 30m")
  String get formattedDuration {
    final hours = duration ~/ 60;
    final minutes = duration % 60;
    return '${hours}h ${minutes}m';
  }

  // Get stops text (e.g., "Direct", "1 Stop")
  String get stopsText {
    if (stops == 0) return 'Direct';
    if (stops == 1) return '1 Stop';
    return '$stops Stops';
  }

  // Copy with method
  FlightModel copyWith({
    String? id,
    String? flightNumber,
    String? airline,
    String? airlineLogo,
    String? origin,
    String? originCity,
    String? destination,
    String? destinationCity,
    DateTime? departureTime,
    DateTime? arrivalTime,
    int? duration,
    int? stops,
    double? price,
    int? seatsAvailable,
    String? aircraft,
    List<String>? amenities,
    String? travelClass,
  }) {
    return FlightModel(
      id: id ?? this.id,
      flightNumber: flightNumber ?? this.flightNumber,
      airline: airline ?? this.airline,
      airlineLogo: airlineLogo ?? this.airlineLogo,
      origin: origin ?? this.origin,
      originCity: originCity ?? this.originCity,
      destination: destination ?? this.destination,
      destinationCity: destinationCity ?? this.destinationCity,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      duration: duration ?? this.duration,
      stops: stops ?? this.stops,
      price: price ?? this.price,
      seatsAvailable: seatsAvailable ?? this.seatsAvailable,
      aircraft: aircraft ?? this.aircraft,
      amenities: amenities ?? this.amenities,
      travelClass: travelClass ?? this.travelClass,
    );
  }
}
