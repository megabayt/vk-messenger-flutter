import 'package:sailor/sailor.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/screens/attachments_screen.dart';
import 'package:vk_messenger_flutter/screens/conversation_screen.dart';
import 'package:vk_messenger_flutter/screens/conversations_screen.dart';
import 'package:vk_messenger_flutter/screens/forward_messages_select.dart';
import 'package:vk_messenger_flutter/screens/forwarded_messages_screen.dart';
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
            params.param('fromId'),
            params.param('attachmentIndex'),
            params.param('attachments'),
          ),
          params: [
            SailorParam<int>(name: 'fromId'),
            SailorParam<int>(name: 'attachmentIndex'),
            SailorParam<List<Attachment>>(name: 'attachments'),
          ],
        ),
        SailorRoute(
          name: ForwardedMessagesScreen.routeUrl,
          builder: (context, args, params) => ForwardedMessagesScreen(
            params.param('fwdMessages'),
          ),
          params: [
            SailorParam<List<Message>>(name: 'fwdMessages'),
          ],
        ),
        SailorRoute(
          name: ForwardMessagesSelect.routeUrl,
          builder: (context, args, params) => ForwardMessagesSelect(),
        ),
        SailorRoute(
          name: AttachmentsScreen.routeUrl,
          builder: (context, args, params) => AttachmentsScreen(),
        )
      ],
    );
  }
}
