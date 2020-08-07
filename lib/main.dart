import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/screens/chat_page.dart';
import 'package:vk_messenger_flutter/screens/chats_page.dart';
import 'package:vk_messenger_flutter/screens/error_page.dart';
import 'package:vk_messenger_flutter/screens/initial_page.dart';
import 'package:vk_messenger_flutter/store/auth_store.dart';
import 'package:vk_messenger_flutter/store/chats_store.dart';
import 'package:vk_messenger_flutter/store/chat_store.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthStore()),
        ChangeNotifierProvider(create: (_) => ChatsStore()),
        ChangeNotifierProvider(create: (_) => ChatStore()),
      ],
      child: MaterialApp(
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
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                  builder: (_) => Consumer<AuthStore>(
                        builder: (consumerContext, authStoreData, _) {
                          final isAuthenticated = authStoreData.isAuthenticated;
                          if (!isAuthenticated) {
                            return InitialPage();
                          }
                          return ChatsPage();
                        },
                      ));
            case ChatsPage.routeUrl:
              return MaterialPageRoute(builder: (_) => ChatsPage());
            case ChatPage.routeUrl:
              return MaterialPageRoute(builder: (_) => ChatPage((settings.arguments as Map<String, int>)['peerId']));
            default:
              return MaterialPageRoute(builder: (_) => ErrorPage());
          }
        },
        routes: {},
      ),
    );
  }
}
