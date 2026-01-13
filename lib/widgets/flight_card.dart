import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import '../utils/date_formatter.dart';
import '../utils/helpers.dart';

class FlightCard extends StatelessWidget {
  final FlightModel flight;
  final VoidCallback? onTap;

  const FlightCard({
    super.key,
    required this.flight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Airline name
              Text(
                flight.airline,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              // Flight route and time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        flight.origin,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        DateFormatter.formatTime(flight.departureTime),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.flight_takeoff, color: Colors.grey[600]),
                      Text(
                        flight.formattedDuration,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        flight.stopsText,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        flight.destination,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        DateFormatter.formatTime(flight.arrivalTime),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 8),
              // Price and book button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Helpers.formatCurrency(flight.price),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'per person',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
