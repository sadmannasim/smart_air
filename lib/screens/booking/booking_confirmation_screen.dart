import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final dynamic booking;
  
  const BookingConfirmationScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
      ),
      body: const Center(
        child: Text('Booking Confirmation Screen - Implementation coming soon'),
      ),
    );
  }
}
