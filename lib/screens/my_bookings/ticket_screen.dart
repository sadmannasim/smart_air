import 'package:flutter/material.dart';

class TicketScreen extends StatelessWidget {
  final dynamic booking;
  
  const TicketScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Ticket'),
      ),
      body: const Center(
        child: Text('Ticket Screen - Implementation coming soon'),
      ),
    );
  }
}
