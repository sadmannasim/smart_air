import 'package:flutter/material.dart';

class FlightDetailsScreen extends StatelessWidget {
  final dynamic flight;
  
  const FlightDetailsScreen({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Details'),
      ),
      body: const Center(
        child: Text('Flight Details Screen - Implementation coming soon'),
      ),
    );
  }
}
