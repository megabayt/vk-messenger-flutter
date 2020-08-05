import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/screens/chats_page.dart';

import 'package:vk_messenger_flutter/screens/initial_screen.dart';
import 'package:vk_messenger_flutter/service_locator.dart';
import 'package:vk_messenger_flutter/store/auth_store.dart';
import 'package:vk_messenger_flutter/store/chats_store.dart';

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
        home: Consumer<AuthStore>(
            builder: (consumerContext, authStoreData, _) {
              final isAuthenticated = authStoreData.isAuthenticated;
              if (!isAuthenticated) {
                return InitialScreen();
              }
              return ChatsPage();
            },
          ),
        routes: {
          ChatsPage.routeUrl: (_) => ChatsPage(),
        },
      ),
    );
  }
}
