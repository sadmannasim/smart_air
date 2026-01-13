import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final dynamic flight;
  final List<dynamic> passengers;
  final List<String> seats;
  
  const PaymentScreen({super.key, required this.flight, required this.passengers, required this.seats});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: const Center(
        child: Text('Payment Screen - Implementation coming soon'),
      ),
    );
  }
}
