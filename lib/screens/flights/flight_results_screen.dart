import 'package:flutter/material.dart';

class FlightResultsScreen extends StatelessWidget {
  final Map<String, dynamic> searchParams;
  
  const FlightResultsScreen({super.key, required this.searchParams});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Results'),
      ),
      body: const Center(
        child: Text('Flight Results Screen - Implementation coming soon'),
      ),
    );
  }
}
