import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:alma_app/core/services/locale_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService.instance() => _instance;

  static final AwesomeNotifications _awesomeNotifications =
      AwesomeNotifications();
  static const String _channelKey = 'basic_channel';
  static const String _channelGroupKey = 'basic_channel';
  static const String _projectId = 'estasherny-43801';
  static const String _bigPictureChannelKey = 'big_picture_channel';
  static const String _progressChannelKey = 'progress_channel';
  static const String _actionChannelKey = 'action_channel';

  /// Initialize Firebase and notification services
  Future<void> init() async {
    // Initialize Awesome Notifications with multiple channels
    await _initializeAwesomeNotifications();

    // Request notification permissions
    await _requestPermission();

    // Set up Firebase Messaging handlers
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Handle notifications when app is terminated
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _navigationToScreen(initialMessage);
    }

    // Listen for token refresh
    _listenForTokenRefresh();

    // Start listening for notification interactions
    await _startListeningNotificationEvents();
  }

  /// Initialize Awesome Notifications with multiple channel configurations
  Future<void> _initializeAwesomeNotifications() async {
    await _awesomeNotifications.initialize(
      null, // Use default icon
      [
        NotificationChannel(
          channelKey: _channelKey,
          channelName: 'Basic Notifications',
          channelDescription: 'Basic notifications for users',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.Max,
          ledColor: Colors.white,
          channelShowBadge: false,
          locked: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
          onlyAlertOnce: true,
        ),
        NotificationChannel(
          channelKey: _bigPictureChannelKey,
          channelName: 'Big Picture Notifications',
          channelDescription: 'Notifications with large images',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          ledColor: Colors.white,
          channelShowBadge: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
        ),
        NotificationChannel(
          channelKey: _progressChannelKey,
          channelName: 'Progress Notifications',
          channelDescription: 'Notifications showing progress',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.Low,
          ledColor: Colors.white,
          channelShowBadge: false,
          onlyAlertOnce: true,
        ),
        NotificationChannel(
          channelKey: _actionChannelKey,
          channelName: 'Action Button Notifications',
          channelDescription: 'Notifications with interactive buttons',
          defaultColor: const Color(0xFF9D50DD),
          importance: NotificationImportance.High,
          ledColor: Colors.white,
          channelShowBadge: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
        ),
      ],
      debug: true,
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: _channelGroupKey,
          channelGroupName: 'Notification Categories',
        ),
      ],
    );
  }

  /// Request notification permissions
  Future<void> _requestPermission() async {
    try {
      final result = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      debugPrint('User granted permission: ${result.authorizationStatus}');
    } catch (e) {
      debugPrint('Error requesting permission: $e');
    }
  }

  /// Get FCM or APNS token based on platform
  Future<String> getToken() async {
    try {
      String? token;
      if (Platform.isIOS) {
        token = await FirebaseMessaging.instance.getAPNSToken();
      } else {
        token = await FirebaseMessaging.instance.getToken();
      }
      if (token == null) {
        debugPrint('Failed to get FCM/APNS token');
        return '';
      }
      debugPrint('FCM/APNS token: $token');
      return token;
    } catch (e) {
      debugPrint('Error getting token: $e');
      return '';
    }
  }

  /// Subscribe to a specific topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (e) {
      debugPrint('Error subscribing to topic: $e');
    }
  }

  /// Listen for FCM token refresh
  void _listenForTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      debugPrint('FCM token refreshed: $fcmToken');
    }).onError((error) {
      debugPrint('Error refreshing FCM token: $error');
    });
  }

  /// Handle foreground messages
  void _onForegroundMessage(RemoteMessage message) {
    debugPrint('Foreground message received: ${message.data}');
    final notificationData = message.notification;
    if (notificationData != null) {
      showInstantNotification(
        title: notificationData.title ?? 'Notification',
        body: notificationData.body ?? '',
        payload: message.data,
      );
    }
  }

  /// Handle messages opened from background
  void _onMessageOpenedApp(RemoteMessage message) {
    _navigationToScreen(message);
  }

  /// Handle background messages
  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    _navigationToScreen(message);
  }

  /// Navigate to  screen
  static void _navigationToScreen(RemoteMessage message) {
    log("aflkjalfjlakjfslkj");
    log(message.data.toString());
    if (message.data.isEmpty) {
      try {
        // final call = MyCallModel.fromJson(  toDynamicMap(message.data));
        //  NavigationService.push(Video(call: MyCallModel.empty()));
      } catch (e) {
        debugPrint('Error navigating to video: $e');
      }
    }
  }

  /// Show instant notification
  Future<void> showInstantNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
    int? id,
  }) async {
    try {
      final notificationId =
          id ?? DateTime.now().millisecondsSinceEpoch.remainder(100000);
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: _channelKey,
          title: title,
          body: body,
          payload: payload != null ? toStringMap(payload) : null,
          notificationLayout: payload != null
              ? NotificationLayout.Default
              : NotificationLayout.Inbox,
        ),
      );
      debugPrint('Instant notification shown: $title');
    } catch (e) {
      debugPrint('Error showing instant notification: $e');
    }
  }

  /// Schedule a notification
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    Map<String, dynamic>? payload,
    int? id,
  }) async {
    try {
      final notificationId =
          id ?? DateTime.now().millisecondsSinceEpoch.remainder(100000);
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: _channelKey,
          title: title,
          body: body,
          payload: payload != null ? toStringMap(payload) : null,
          notificationLayout: payload != null
              ? NotificationLayout.Default
              : NotificationLayout.Inbox,
        ),
        schedule: NotificationCalendar.fromDate(
          date: scheduledTime,
          allowWhileIdle: true,
          preciseAlarm: true,
        ),
      );
      debugPrint('Notification scheduled for: $scheduledTime');
    } catch (e) {
      debugPrint('Error scheduling notification: $e');
    }
  }

  /// Show notification with big picture
  Future<void> showBigPictureNotification({
    required String title,
    required String body,
    required String bigPictureUrl,
    Map<String, dynamic>? payload,
    int? id,
  }) async {
    try {
      final notificationId =
          id ?? DateTime.now().millisecondsSinceEpoch.remainder(100000);
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: _bigPictureChannelKey,
          title: title,
          body: body,
          bigPicture: bigPictureUrl,
          notificationLayout: NotificationLayout.BigPicture,
          payload: payload != null ? toStringMap(payload) : null,
        ),
      );
    } catch (e) {
      debugPrint('Error showing big picture notification: $e');
    }
  }

  /// Show progress bar notification
  Future<void> showProgressNotification({
    required String title,
    required String body,
    required double progress,
    double maxProgress = 100,
    String? payload,
    int? id,
  }) async {
    try {
      final notificationId =
          id ?? DateTime.now().millisecondsSinceEpoch.remainder(100000);
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: _progressChannelKey,
          title: title,
          body: body,
          payload: payload != null ? {'data': payload} : null,
          notificationLayout: NotificationLayout.ProgressBar,
          progress:
              progress.clamp(0, 100), // Ensure progress is between 0 and 100
        ),
      );
      debugPrint(
          'Progress notification shown: $title, Progress: $progress/$maxProgress');
    } catch (e) {
      debugPrint('Error showing progress notification: $e');
    }
  }

  /// Show notification with action buttons
  Future<void> showActionButtonNotification({
    required String title,
    required String body,
    required List<NotificationActionButton> actionButtons,
    String? payload,
    int? id,
  }) async {
    try {
      final notificationId =
          id ?? DateTime.now().millisecondsSinceEpoch.remainder(100000);
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: _actionChannelKey,
          title: title,
          body: body,
          payload: payload != null ? {'data': payload} : null,
          notificationLayout: NotificationLayout.Default,
        ),
        actionButtons: actionButtons,
      );
      debugPrint('Action button notification shown: $title');
    } catch (e) {
      debugPrint('Error showing action button notification: $e');
    }
  }

  static Map<String, String?>? toStringMap(Map<String, dynamic>? input) {
    if (input == null) {
      debugPrint('Input map is null, returning null');
      return null;
    }
    try {
      final result = <String, String?>{};
      input.forEach((key, value) {
        result[key] = value?.toString();
      });
      debugPrint('Converted to String map: $result');
      return result;
    } catch (e) {
      debugPrint('Error converting to String map: $e');
      return null;
    }
  }

  static Map<String, String> toDynamicMap(Map<String, String?>? input) {
    if (input == null) {
      debugPrint('Input map is null, returning empty dynamic map');
      return {};
    }
    try {
      final result = <String, String>{};
      input.forEach((key, value) {
        result[key] = value!;
      });
      debugPrint('Converted to dynamic map: $result');
      return result;
    } catch (e) {
      debugPrint('Error converting to dynamic map: $e');
      return {};
    }
  }

  /// Start listening for notification events
  Future<void> _startListeningNotificationEvents() async {
    debugPrint('Starting notification event listeners');
    _awesomeNotifications.setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
    );
  }

  /// Handle notification actions
  static Future<void> _onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    debugPrint(
        'Notification action received: ${receivedAction.buttonKeyPressed}');
    log("afakfj ${receivedAction.payload.toString()}");

    if (receivedAction.payload != null) {
      try {
        //   Map<String, String> json = toDynamicMap(receivedAction.payload!);
        //  final call = MyCallModel.fromJson(json);
        //  NavigationService.push(Video(call: call));
      } catch (e) {
        debugPrint('Error handling notification action: $e');
      }
    }
  }

  /// Get Firebase access token for sending push notifications
  static Future<String> _getAccessToken() async {
    const serviceAccountJson = {};

    const scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
    ];

    try {
      final client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
      );
      final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client,
      );
      client.close();
      return credentials.accessToken.data;
    } catch (e) {
      debugPrint('Error obtaining access token: $e');
      return '';
    }
  }

  /// Send push notification
  Future<void> sendPushNotification({
    required String deviceToken,
    required String title,
    required String body,
    //  required MyCallModel data,
  }) async {
    try {
      final accessToken = await _getAccessToken();
      if (accessToken.isEmpty) {
        debugPrint('Failed to obtain access token');
        return;
      }
      //  log("jsssssob ${data.toJson()}");
      final endpointFCM =
          'https://fcm.googleapis.com/v1/projects/$_projectId/messages:send';
      final message = {
        "message": {
          "token": deviceToken,
          "notification": {"title": title, "body": body},
          //    "data": data.toJson(),
        },
      };

      final response = await sl<Dio>().post(
        endpointFCM,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
        data: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        debugPrint('Push notification sent successfully');
      } else {
        debugPrint('Failed to send push notification: ${response.data}');
      }
    } on DioException catch (e) {
      debugPrint('Error sending push notification: $e');
    }
  }
}
// /// ios permissions in info.plist
// /**
//   <key>NSLocalNetworkUsageDescription</key>
// <string>Allow the debugger to connect over your local network.</string>
// <key>NSBonjourServices</key>
// <array>
//     <string>_dartVmService._tcp</string>
//     <string>_dartobservatory._tcp</string>
// </array>
//
//  */
