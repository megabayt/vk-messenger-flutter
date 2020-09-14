import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/friends/friends_bloc.dart';
import 'package:vk_messenger_flutter/screens/router.dart';

import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/blocs/auth/auth_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';

void main() {
  setupServiceLocator();
  Router.createRoutes();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ConversationsBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => AttachmentsBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ConversationBloc(
            BlocProvider.of<ConversationsBloc>(context),
            BlocProvider.of<AttachmentsBloc>(context),
          ),
        ),
        BlocProvider(
          create: (_) => FriendsBloc()..add(FriendsFetch()),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            BlocProvider.of<ConversationsBloc>(context),
          )..add(UserLogIn()),
          lazy: false,
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
      onGenerateRoute: Router.sailor.generator(),
      navigatorKey: Router.sailor.navigatorKey,
      navigatorObservers: [Router.sailor.navigationStackObserver],
    );
  }
}
