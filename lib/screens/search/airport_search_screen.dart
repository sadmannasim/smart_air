import 'package:flutter/material.dart';

class AirportSearchScreen extends StatelessWidget {
  final bool isOrigin;
  
  const AirportSearchScreen({super.key, required this.isOrigin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isOrigin ? 'Select Origin' : 'Select Destination'),
      ),
      body: const Center(
        child: Text('Airport Search Screen - Implementation coming soon'),
      ),
    );
  }
}
