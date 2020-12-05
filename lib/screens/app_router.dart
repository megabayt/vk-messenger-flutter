import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailor/sailor.dart';

import 'package:vk_messenger_flutter/blocs/auth/auth_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
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
          name: SplashScreen.routeUrl,
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (listenerContext, state) {
        if (state is AuthNotAuthenticated || state is AuthFailure) {
          AppRouter.sailor.popUntil((_) => false);
          AppRouter.sailor.navigate(SplashScreen.routeUrl);
          BlocProvider.of<AuthBloc>(listenerContext).add(UserLogIn());
        }
        if (state is AuthAuthenticated) {
          AppRouter.sailor.popUntil((_) => false);
          AppRouter.sailor.navigate(ConversationsScreen.routeUrl);
          BlocProvider.of<ConversationsBloc>(listenerContext)
              .add(ConversationsFetch());
          // BlocProvider.of<LongPollingBloc>(listenerContext).add(LongPollingPoll());
        }
      },
      builder: (_, state) {
        return child;
      },
    );
  }
}
