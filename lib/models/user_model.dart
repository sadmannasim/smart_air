import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final DateTime createdAt;
  final List<Map<String, dynamic>> savedTravelers;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.phoneNumber,
    required this.createdAt,
    this.savedTravelers = const [],
  });

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'createdAt': Timestamp.fromDate(createdAt),
      'savedTravelers': savedTravelers,
    };
  }

  // Create UserModel from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      photoUrl: map['photoUrl'],
      phoneNumber: map['phoneNumber'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      savedTravelers: List<Map<String, dynamic>>.from(
        map['savedTravelers'] ?? [],
      ),
    );
  }

  // Create UserModel from Firebase User
  factory UserModel.fromFirebaseUser(
    String id,
    String email,
    String displayName,
  ) {
    return UserModel(
      id: id,
      email: email,
      displayName: displayName,
      createdAt: DateTime.now(),
    );
  }

  // Copy with method for updates
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
    DateTime? createdAt,
    List<Map<String, dynamic>>? savedTravelers,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
      savedTravelers: savedTravelers ?? this.savedTravelers,
    );
  }
}
