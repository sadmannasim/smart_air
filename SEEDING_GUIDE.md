# Smart Air - Data Seeding Guide

This document provides instructions for seeding initial data into your Firebase Firestore database.

## Prerequisites

- Firebase project set up and configured
- Firebase CLI installed
- Firestore database created

## Seeding Airports Data

### Option 1: Manual Upload (Firebase Console)

1. Go to Firebase Console > Firestore Database
2. Create a collection named `airports`
3. Import the data from `assets/data/airports.json`
4. Each airport should be a document with auto-generated ID

### Option 2: Using Dart Script

Create a file `lib/scripts/seed_data.dart`:

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/airport_model.dart';

Future<void> seedAirports() async {
  final firestore = FirebaseFirestore.instance;
  
  final airports = [
    AirportModel(
      id: 'jfk',
      code: 'JFK',
      name: 'John F. Kennedy International Airport',
      city: 'New York',
      country: 'United States',
      searchTerms: ['jfk', 'new york', 'kennedy', 'nyc'],
    ),
    // Add more airports...
  ];

  for (final airport in airports) {
    await firestore
        .collection('airports')
        .doc(airport.id)
        .set(airport.toMap());
    print('Added airport: ${airport.code}');
  }
}
```

## Seeding Sample Flights

Create sample flights for testing:

```dart
Future<void> seedFlights() async {
  final firestore = FirebaseFirestore.instance;
  final now = DateTime.now();
  
  final flights = [
    FlightModel(
      id: 'flight1',
      flightNumber: 'SA101',
      airline: 'Sky Airlines',
      airlineLogo: '',
      origin: 'JFK',
      originCity: 'New York',
      destination: 'LAX',
      destinationCity: 'Los Angeles',
      departureTime: now.add(Duration(days: 7, hours: 10)),
      arrivalTime: now.add(Duration(days: 7, hours: 16)),
      duration: 360, // minutes
      stops: 0,
      price: 299.99,
      seatsAvailable: 50,
      aircraft: 'Boeing 737',
      amenities: ['WiFi', 'In-flight Entertainment', 'Meals'],
      travelClass: 'Economy',
    ),
    // Add more flights...
  ];

  for (final flight in flights) {
    await firestore
        .collection('flights')
        .doc(flight.id)
        .set(flight.toMap());
    print('Added flight: ${flight.flightNumber}');
  }
}
```

## Running the Seed Script

1. Create a temporary screen or button in your app to trigger seeding
2. Call the seed functions once during development
3. Remove the seeding code before production deployment

Example:

```dart
// In a development-only screen
ElevatedButton(
  onPressed: () async {
    await seedAirports();
    await seedFlights();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data seeded successfully!')),
    );
  },
  child: Text('Seed Data'),
)
```

## Important Notes

⚠️ **Warning:** 
- Run seeding scripts only in development
- Do not commit seed scripts to production
- Check for existing data before seeding to avoid duplicates
- Seeding will incur Firestore read/write costs

## Sample Data Templates

### Airport Template
```json
{
  "code": "XXX",
  "name": "Airport Full Name",
  "city": "City Name",
  "country": "Country Name",
  "searchTerms": ["term1", "term2", "term3"]
}
```

### Flight Template
```json
{
  "flightNumber": "XX000",
  "airline": "Airline Name",
  "airlineLogo": "url_to_logo",
  "origin": "JFK",
  "originCity": "New York",
  "destination": "LAX",
  "destinationCity": "Los Angeles",
  "departureTime": "2024-12-25T10:00:00",
  "arrivalTime": "2024-12-25T16:00:00",
  "duration": 360,
  "stops": 0,
  "price": 299.99,
  "seatsAvailable": 150,
  "aircraft": "Boeing 737",
  "amenities": ["WiFi", "Meals"],
  "travelClass": "Economy"
}
```

## Bulk Import with Firebase CLI

You can also use Firebase CLI for bulk imports:

```bash
firebase firestore:import ./firestore-data
```

For more information, visit: https://firebase.google.com/docs/firestore/manage-data/export-import
