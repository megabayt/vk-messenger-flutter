import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:vk_messenger_flutter/blocs/firebase/firebase_bloc.dart';
import 'package:vk_messenger_flutter/blocs/stickers/stickers_bloc.dart';
import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/friends/friends_bloc.dart';
import 'package:vk_messenger_flutter/blocs/long_polling/long_polling_bloc.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/blocs/auth/auth_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    // onDidReceiveLocalNotification:
    //     (int id, String title, String body, String payload) async {
    //   didReceiveLocalNotificationSubject.add(ReceivedNotification(
    //       id: id, title: title, body: body, payload: payload));
    // },
  );
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('default', 'default', 'default',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  final title = message.data.containsKey('title')
      ? message.data['title']
      : 'Новое сообщение';
  final body = message.data.containsKey('body')
      ? message.data['body']
      : 'Новое сообщение';

  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: 'item x');

  print("Handling a background message: ${message.messageId}");
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  setupServiceLocator();
  AppRouter.createRoutes();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FirebaseBloc()..add(FirebaseInit()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
        BlocProvider(create: (_) => ProfilesBloc()),
        BlocProvider(
            create: (context) => ConversationsBloc(
                  BlocProvider.of<ProfilesBloc>(context),
                )),
        BlocProvider(create: (_) => AttachmentsBloc()),
        BlocProvider(
            create: (context) => ConversationBloc(
                  BlocProvider.of<ConversationsBloc>(context),
                  BlocProvider.of<AttachmentsBloc>(context),
                )),
        BlocProvider(
          create: (_) => FriendsBloc()..add(FriendsFetch()),
        ),
        BlocProvider(
          create: (_) => StickersBloc()..add(StickersFetch()),
        ),
        BlocProvider(
          create: (context) => LongPollingBloc(
            BlocProvider.of<ConversationBloc>(context),
            BlocProvider.of<ProfilesBloc>(context),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vk Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.blue,
        accentColor: Colors.pinkAccent,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      onGenerateRoute: AppRouter.sailor.generator(),
      navigatorKey: AppRouter.sailor.navigatorKey,
      navigatorObservers: [AppRouter.sailor.navigationStackObserver],
    );
  }
}
