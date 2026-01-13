import 'package:cloud_firestore/cloud_firestore.dart';
import 'passenger_model.dart';

class BookingModel {
  final String id;
  final String userId;
  final String flightId;
  final String bookingReference;
  final List<PassengerModel> passengers;
  final double totalPrice;
  final String status; // pending, confirmed, completed, cancelled
  final String paymentStatus; // pending, success, failed
  final DateTime bookedAt;
  final List<String> seatNumbers;
  final String flightNumber;
  final String airline;
  final String origin;
  final String destination;
  final DateTime departureTime;
  final DateTime arrivalTime;

  BookingModel({
    required this.id,
    required this.userId,
    required this.flightId,
    required this.bookingReference,
    required this.passengers,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    required this.bookedAt,
    required this.seatNumbers,
    required this.flightNumber,
    required this.airline,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
  });

  // Convert BookingModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'flightId': flightId,
      'bookingReference': bookingReference,
      'passengers': passengers.map((p) => p.toMap()).toList(),
      'totalPrice': totalPrice,
      'status': status,
      'paymentStatus': paymentStatus,
      'bookedAt': Timestamp.fromDate(bookedAt),
      'seatNumbers': seatNumbers,
      'flightNumber': flightNumber,
      'airline': airline,
      'origin': origin,
      'destination': destination,
      'departureTime': Timestamp.fromDate(departureTime),
      'arrivalTime': Timestamp.fromDate(arrivalTime),
    };
  }

  // Create BookingModel from Firestore document
  factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
    return BookingModel(
      id: id,
      userId: map['userId'] ?? '',
      flightId: map['flightId'] ?? '',
      bookingReference: map['bookingReference'] ?? '',
      passengers: (map['passengers'] as List<dynamic>)
          .map((p) => PassengerModel.fromMap(p as Map<String, dynamic>))
          .toList(),
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
      status: map['status'] ?? 'pending',
      paymentStatus: map['paymentStatus'] ?? 'pending',
      bookedAt: (map['bookedAt'] as Timestamp).toDate(),
      seatNumbers: List<String>.from(map['seatNumbers'] ?? []),
      flightNumber: map['flightNumber'] ?? '',
      airline: map['airline'] ?? '',
      origin: map['origin'] ?? '',
      destination: map['destination'] ?? '',
      departureTime: (map['departureTime'] as Timestamp).toDate(),
      arrivalTime: (map['arrivalTime'] as Timestamp).toDate(),
    );
  }

  // Generate booking reference
  static String generateBookingReference() {
    final random = DateTime.now().millisecondsSinceEpoch;
    return 'SA${random.toString().substring(random.toString().length - 8)}';
  }

  // Copy with method
  BookingModel copyWith({
    String? id,
    String? userId,
    String? flightId,
    String? bookingReference,
    List<PassengerModel>? passengers,
    double? totalPrice,
    String? status,
    String? paymentStatus,
    DateTime? bookedAt,
    List<String>? seatNumbers,
    String? flightNumber,
    String? airline,
    String? origin,
    String? destination,
    DateTime? departureTime,
    DateTime? arrivalTime,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      flightId: flightId ?? this.flightId,
      bookingReference: bookingReference ?? this.bookingReference,
      passengers: passengers ?? this.passengers,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      bookedAt: bookedAt ?? this.bookedAt,
      seatNumbers: seatNumbers ?? this.seatNumbers,
      flightNumber: flightNumber ?? this.flightNumber,
      airline: airline ?? this.airline,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
    );
  }

  // Check if booking is upcoming
  bool get isUpcoming {
    return status == 'confirmed' && departureTime.isAfter(DateTime.now());
  }

  // Check if booking is completed
  bool get isCompleted {
    return status == 'completed' || departureTime.isBefore(DateTime.now());
  }

  // Check if booking is cancelled
  bool get isCancelled {
    return status == 'cancelled';
  }
}
