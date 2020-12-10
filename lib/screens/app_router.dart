import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

import 'package:vk_messenger_flutter/blocs/auth/auth_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/blocs/firebase/firebase_bloc.dart';
import 'package:vk_messenger_flutter/blocs/long_polling/long_polling_bloc.dart';
import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/message.dart';
import 'package:vk_messenger_flutter/screens/attachments_screen.dart';
import 'package:vk_messenger_flutter/screens/conversation_screen.dart';
import 'package:vk_messenger_flutter/screens/conversations_screen.dart';
import 'package:vk_messenger_flutter/screens/forward_messages_select.dart';
import 'package:vk_messenger_flutter/screens/forwarded_messages_screen.dart';
import 'package:vk_messenger_flutter/screens/photos_screen.dart';
import 'package:vk_messenger_flutter/screens/select_geo_screen.dart';
import 'package:vk_messenger_flutter/screens/show_geo_screen.dart';
import 'package:vk_messenger_flutter/screens/splash_screen.dart';

class AppRouter {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes(
      [
        SailorRoute(
          name: SplashScreen.routeUrlFirebase,
          builder: (context, args, params) => AppRouteGuard(SplashScreen()),
        ),
        SailorRoute(
          name: SplashScreen.routeUrlVk,
          builder: (context, args, params) => AppRouteGuard(SplashScreen()),
        ),
        SailorRoute(
          name: ConversationsScreen.routeUrl,
          builder: (context, args, params) =>
              AppRouteGuard(ConversationsScreen()),
        ),
        SailorRoute(
          name: ConversationScreen.routeUrl,
          builder: (context, args, params) =>
              AppRouteGuard(ConversationScreen()),
        ),
        SailorRoute(
          name: PhotosScreen.routeUrl,
          builder: (context, args, params) => AppRouteGuard(PhotosScreen(
            params.param('fromId'),
            params.param('attachmentIndex'),
            params.param('attachments'),
          )),
          params: [
            SailorParam<int>(name: 'fromId'),
            SailorParam<int>(name: 'attachmentIndex'),
            SailorParam<List<Attachment>>(name: 'attachments'),
          ],
        ),
        SailorRoute(
          name: ForwardedMessagesScreen.routeUrl,
          builder: (context, args, params) =>
              AppRouteGuard(ForwardedMessagesScreen(
            params.param('fwdMessages'),
          )),
          params: [
            SailorParam<List<Message>>(name: 'fwdMessages'),
          ],
        ),
        SailorRoute(
          name: ForwardMessagesSelect.routeUrl,
          builder: (context, args, params) =>
              AppRouteGuard(ForwardMessagesSelect()),
        ),
        SailorRoute(
          name: AttachmentsScreen.routeUrl,
          builder: (context, args, params) =>
              AppRouteGuard(AttachmentsScreen()),
        ),
        SailorRoute(
          name: SelectGeoScreen.routeUrl,
          builder: (context, args, params) => AppRouteGuard(SelectGeoScreen()),
        ),
        SailorRoute(
            name: ShowGeoScreen.routeUrl,
            builder: (context, args, params) => AppRouteGuard(ShowGeoScreen(
                  params.param('longitude'),
                  params.param('latitude'),
                  params.param('place'),
                )),
            params: [
              SailorParam<double>(name: 'longitude'),
              SailorParam<double>(name: 'latitude'),
              SailorParam<String>(name: 'place'),
            ]),
      ],
    );
  }
}

class AppRouteGuard extends StatelessWidget {
  final Widget child;

  AppRouteGuard(this.child);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirebaseBloc, FirebaseState>(
      listener: (_, firebaseState) {
        if (firebaseState is FirebaseInitial ||
            firebaseState is FirebaseInitFailed) {
          AppRouter.sailor.popUntil((_) => false); // go to blank
          AppRouter.sailor.navigate(
              SplashScreen.routeUrlFirebase); // go to firebase splashscreen
          BlocProvider.of<FirebaseBloc>(context)
              .add(FirebaseInit()); // initialize firebase
        }
        if (firebaseState is FirebaseInitiated) {
          AppRouter.sailor.popUntil((_) => false); //go to blank
          AppRouter.sailor
              .navigate(SplashScreen.routeUrlVk); // go to vk splashscreen
          BlocProvider.of<AuthBloc>(context).add(UserLogIn()); // vk login
        }
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (_, authState) {
          if (authState is AuthNotAuthenticated || authState is AuthFailure) {
            AppRouter.sailor.popUntil((_) => false); //go to blank
            AppRouter.sailor
                .navigate(SplashScreen.routeUrlVk); // return to vk splashscreen
            BlocProvider.of<FirebaseBloc>(context)
                .add(FirebasePushUnsub()); // unsub push notif
            BlocProvider.of<AuthBloc>(context).add(UserLogIn()); // retry login
          }
          if (authState is AuthAuthenticated) {
            AppRouter.sailor.popUntil((_) => false); //go to blank
            AppRouter.sailor
                .navigate(ConversationsScreen.routeUrl); // go to conversations
            BlocProvider.of<ConversationsBloc>(context)
                .add(ConversationsFetch()); // fetch conversations
            BlocProvider.of<LongPollingBloc>(context)
                .add(LongPollingPoll()); // long polling
            BlocProvider.of<FirebaseBloc>(context)
                .add(FirebasePushSub()); // sub push notif
          }
        },
        child: child,
      ),
    );
  }
}
