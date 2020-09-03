import 'package:sailor/sailor.dart';
import 'package:vk_messenger_flutter/screens/conversation_screen.dart';

import 'package:vk_messenger_flutter/screens/conversations_screen.dart';
import 'package:vk_messenger_flutter/screens/photos_screen.dart';
import 'package:vk_messenger_flutter/screens/splash_screen.dart';

class Router {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes(
      [
        SailorRoute(
          name: SplashScreen.routeUrl,
          builder: (context, args, params) => SplashScreen(),
        ),
        SailorRoute(
          name: ConversationsScreen.routeUrl,
          builder: (context, args, params) => ConversationsScreen(),
        ),
        SailorRoute(
          name: ConversationScreen.routeUrl,
          builder: (context, args, params) => ConversationScreen(),
        ),
        SailorRoute(
          name: PhotosScreen.routeUrl,
          builder: (context, args, params) => PhotosScreen(
              params.param('messageIndex'), params.param('attachmentIndex')),
          params: [
            SailorParam<int>(name: 'messageIndex'),
            SailorParam<int>(name: 'attachmentIndex'),
          ],
        )
      ],
    );
  }
}
