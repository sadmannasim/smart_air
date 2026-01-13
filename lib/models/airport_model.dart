import 'package:cloud_firestore/cloud_firestore.dart';

class AirportModel {
  final String id;
  final String code; // IATA code (e.g., JFK, LAX)
  final String name;
  final String city;
  final String country;
  final List<String> searchTerms;

  AirportModel({
    required this.id,
    required this.code,
    required this.name,
    required this.city,
    required this.country,
    required this.searchTerms,
  });

  // Convert AirportModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'city': city,
      'country': country,
      'searchTerms': searchTerms,
    };
  }

  // Create AirportModel from Firestore document
  factory AirportModel.fromMap(Map<String, dynamic> map, String id) {
    return AirportModel(
      id: id,
      code: map['code'] ?? '',
      name: map['name'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      searchTerms: List<String>.from(map['searchTerms'] ?? []),
    );
  }

  // Get display text for airport selection
  String get displayText => '$city ($code)';

  // Get full display text with country
  String get fullDisplayText => '$city, $country ($code)';

  // Get description
  String get description => name;

  // Copy with method
  AirportModel copyWith({
    String? id,
    String? code,
    String? name,
    String? city,
    String? country,
    List<String>? searchTerms,
  }) {
    return AirportModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      city: city ?? this.city,
      country: country ?? this.country,
      searchTerms: searchTerms ?? this.searchTerms,
    );
  }
}
