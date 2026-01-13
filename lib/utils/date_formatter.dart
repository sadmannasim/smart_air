import 'package:intl/intl.dart';

class DateFormatter {
  // Format date as "dd MMM yyyy" (e.g., "25 Dec 2024")
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  // Format date as "dd/MM/yyyy" (e.g., "25/12/2024")
  static String formatDateSlash(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Format time as "HH:mm" (e.g., "14:30")
  static String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  // Format time as "hh:mm a" (e.g., "02:30 PM")
  static String formatTime12Hour(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  // Format date and time (e.g., "25 Dec 2024, 14:30")
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }

  // Format full date (e.g., "Monday, 25 December 2024")
  static String formatFullDate(DateTime date) {
    return DateFormat('EEEE, dd MMMM yyyy').format(date);
  }

  // Format short date (e.g., "25 Dec")
  static String formatShortDate(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }

  // Format month and year (e.g., "December 2024")
  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  // Format day of week (e.g., "Monday")
  static String formatDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  // Format short day of week (e.g., "Mon")
  static String formatShortDayOfWeek(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  // Get relative time (e.g., "2 hours ago", "in 3 days")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.isNegative) {
      // Future date
      final futureDiff = dateTime.difference(now);

      if (futureDiff.inDays > 365) {
        final years = (futureDiff.inDays / 365).floor();
        return 'in ${years} ${years == 1 ? 'year' : 'years'}';
      } else if (futureDiff.inDays > 30) {
        final months = (futureDiff.inDays / 30).floor();
        return 'in ${months} ${months == 1 ? 'month' : 'months'}';
      } else if (futureDiff.inDays > 0) {
        return 'in ${futureDiff.inDays} ${futureDiff.inDays == 1 ? 'day' : 'days'}';
      } else if (futureDiff.inHours > 0) {
        return 'in ${futureDiff.inHours} ${futureDiff.inHours == 1 ? 'hour' : 'hours'}';
      } else if (futureDiff.inMinutes > 0) {
        return 'in ${futureDiff.inMinutes} ${futureDiff.inMinutes == 1 ? 'minute' : 'minutes'}';
      } else {
        return 'in a few seconds';
      }
    } else {
      // Past date
      if (difference.inDays > 365) {
        final years = (difference.inDays / 365).floor();
        return '${years} ${years == 1 ? 'year' : 'years'} ago';
      } else if (difference.inDays > 30) {
        final months = (difference.inDays / 30).floor();
        return '${months} ${months == 1 ? 'month' : 'months'} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'just now';
      }
    }
  }

  // Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  // Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  // Format with today/tomorrow/yesterday
  static String formatWithRelative(DateTime date) {
    if (isToday(date)) {
      return 'Today, ${formatTime(date)}';
    } else if (isTomorrow(date)) {
      return 'Tomorrow, ${formatTime(date)}';
    } else if (isYesterday(date)) {
      return 'Yesterday, ${formatTime(date)}';
    } else {
      return formatDateTime(date);
    }
  }

  // Calculate flight duration
  static String calculateDuration(DateTime departure, DateTime arrival) {
    final duration = arrival.difference(departure);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }

  // Parse date from string
  static DateTime? parseDate(String dateString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  // Format for API (ISO 8601)
  static String formatForAPI(DateTime date) {
    return date.toIso8601String();
  }

  // Get time remaining until date
  static String getTimeRemaining(DateTime futureDate) {
    final now = DateTime.now();
    final difference = futureDate.difference(now);

    if (difference.isNegative) {
      return 'Expired';
    }

    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);

    if (days > 0) {
      return '$days days, $hours hours';
    } else if (hours > 0) {
      return '$hours hours, $minutes minutes';
    } else if (minutes > 0) {
      return '$minutes minutes';
    } else {
      return 'Less than a minute';
    }
  }
}
