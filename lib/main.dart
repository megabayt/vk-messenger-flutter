import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/friends/friends_bloc.dart';
import 'package:vk_messenger_flutter/blocs/stickers/stickers_bloc.dart';

import 'package:vk_messenger_flutter/screens/app_router.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/blocs/auth/auth_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';

void main() {
  setupServiceLocator();
  AppRouter.createRoutes();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc()..add(UserLogIn()),
          lazy: false,
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
