class PassengerModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String passportNumber;
  final String nationality;
  final String passengerType; // Adult, Child, Infant
  final String? seatNumber;

  PassengerModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.passportNumber,
    required this.nationality,
    required this.passengerType,
    this.seatNumber,
  });

  // Get full name
  String get fullName => '$firstName $lastName';

  // Convert PassengerModel to Map
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'passportNumber': passportNumber,
      'nationality': nationality,
      'passengerType': passengerType,
      'seatNumber': seatNumber,
    };
  }

  // Create PassengerModel from Map
  factory PassengerModel.fromMap(Map<String, dynamic> map) {
    return PassengerModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      passportNumber: map['passportNumber'] ?? '',
      nationality: map['nationality'] ?? '',
      passengerType: map['passengerType'] ?? 'Adult',
      seatNumber: map['seatNumber'],
    );
  }

  // Copy with method
  PassengerModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? passportNumber,
    String? nationality,
    String? passengerType,
    String? seatNumber,
  }) {
    return PassengerModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      passportNumber: passportNumber ?? this.passportNumber,
      nationality: nationality ?? this.nationality,
      passengerType: passengerType ?? this.passengerType,
      seatNumber: seatNumber ?? this.seatNumber,
    );
  }

  // Calculate age
  int get age {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }
}
