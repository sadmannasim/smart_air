import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/booking_model.dart';
import '../utils/date_formatter.dart';

class TicketWidget extends StatelessWidget {
  final BookingModel booking;

  const TicketWidget({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ticket header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'E-Ticket',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  booking.bookingReference,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ],
            ),
          ),

          // Ticket body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // QR Code
                QrImageView(
                  data: booking.bookingReference,
                  version: QrVersions.auto,
                  size: 150,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // Flight info
                _buildInfoRow(context, 'From', booking.origin),
                _buildInfoRow(context, 'To', booking.destination),
                _buildInfoRow(
                  context,
                  'Departure',
                  DateFormatter.formatDateTime(booking.departureTime),
                ),
                _buildInfoRow(context, 'Airline', booking.airline),
                _buildInfoRow(
                  context,
                  'Passengers',
                  booking.passengers.length.toString(),
                ),
                _buildInfoRow(context, 'Seats', booking.seatNumbers.join(', ')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
