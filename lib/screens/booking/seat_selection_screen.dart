import 'package:flutter/material.dart';

class SeatSelectionScreen extends StatelessWidget {
  final dynamic flight;
  final List<dynamic> passengers;
  
  const SeatSelectionScreen({super.key, required this.flight, required this.passengers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Seats'),
      ),
      body: const Center(
        child: Text('Seat Selection Screen - Implementation coming soon'),
      ),
    );
  }
}
