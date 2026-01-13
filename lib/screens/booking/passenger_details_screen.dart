import 'package:flutter/material.dart';

class PassengerDetailsScreen extends StatelessWidget {
  final dynamic flight;
  final List<dynamic> passengers;
  
  const PassengerDetailsScreen({super.key, required this.flight, required this.passengers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Details'),
      ),
      body: const Center(
        child: Text('Passenger Details Screen - Implementation coming soon'),
      ),
    );
  }
}
