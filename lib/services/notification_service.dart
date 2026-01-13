import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // Initialize notification service
  Future<void> initialize() async {
    // Request permission for iOS
    await _requestPermission();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Configure FCM
    await _configureFCM();
  }

  // Request notification permission
  Future<void> _requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted notification permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional notification permission');
    } else {
      print('User declined notification permission');
    }
  }

  // Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  // Configure FCM
  Future<void> _configureFCM() async {
    // Get FCM token
    final token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background messages
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Handle when app is opened from terminated state
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  // Handle foreground message
  void _handleForegroundMessage(RemoteMessage message) {
    print('Foreground message: ${message.notification?.title}');

    // Show local notification
    if (message.notification != null) {
      _showLocalNotification(
        title: message.notification!.title ?? '',
        body: message.notification!.body ?? '',
        payload: message.data.toString(),
      );
    }
  }

  // Handle background message
  void _handleBackgroundMessage(RemoteMessage message) {
    print('Background message: ${message.notification?.title}');
    // Handle navigation based on message data
  }

  // Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    print('Notification tapped: ${response.payload}');
    // Handle navigation based on payload
  }

  // Show local notification
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'smart_air_channel',
      'Smart Air Notifications',
      channelDescription: 'Notifications for Smart Air bookings and flights',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecond,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Send booking confirmation notification
  Future<void> sendBookingConfirmation({
    required String bookingReference,
    required String flightNumber,
  }) async {
    await _showLocalNotification(
      title: 'Booking Confirmed! ✈️',
      body:
          'Your booking $bookingReference for flight $flightNumber is confirmed.',
    );
  }

  // Send flight reminder notification
  Future<void> sendFlightReminder({
    required String flightNumber,
    required DateTime departureTime,
  }) async {
    await _showLocalNotification(
      title: 'Flight Reminder 🛫',
      body: 'Your flight $flightNumber departs soon. Have a safe journey!',
    );
  }

  // Send price alert notification
  Future<void> sendPriceAlert({
    required String route,
    required double price,
  }) async {
    await _showLocalNotification(
      title: 'Price Alert! 💰',
      body: 'Great deal on $route for just \$${price.toStringAsFixed(2)}',
    );
  }

  // Send promotional notification
  Future<void> sendPromotionalOffer({
    required String title,
    required String message,
  }) async {
    await _showLocalNotification(
      title: title,
      body: message,
    );
  }

  // Schedule notification
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // Implementation for scheduled notifications
    // Would require additional setup with timezone package
    print('Notification scheduled for $scheduledTime');
  }

  // Get FCM token
  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background message: ${message.notification?.title}');
}
