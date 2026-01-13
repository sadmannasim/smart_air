import 'package:flutter/material.dart';
import '../models/airport_model.dart';

class AirportTile extends StatelessWidget {
  final AirportModel airport;
  final VoidCallback? onTap;

  const AirportTile({
    super.key,
    required this.airport,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Icon(
          Icons.flight,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(airport.displayText),
      subtitle: Text(airport.description),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
