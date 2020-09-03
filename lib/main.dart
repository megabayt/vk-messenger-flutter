import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/send/send_bloc.dart';
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
          create: (_) => ConversationBloc(),
        ),
        BlocProvider(
          create: (_) => ConversationsBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) {
            return SendBloc(
              BlocProvider.of<ConversationsBloc>(context),
              BlocProvider.of<ConversationBloc>(context),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            final authBloc = AuthBloc(
              BlocProvider.of<ConversationsBloc>(context),
            );

            authBloc.add(UserLogIn());

            return authBloc;
          },
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
