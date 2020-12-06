import 'package:copy_with_extension/copy_with_extension.dart';

import 'package:vk_messenger_flutter/local_models/message.dart';
import 'package:vk_messenger_flutter/vk_models/conversation_item.dart';
import 'package:vk_messenger_flutter/vk_models/peer_type.dart';

part 'conversation.g.dart';

@CopyWith()
class Conversation {
  Conversation({
    this.id,
    this.type,
    this.localId,
    this.unreadCount,
    this.messagesCount = 0,
    this.messages,
    this.activeIds,
    this.title,
    this.inRead,
    this.outRead,
  });

  final int id;
  final VkPeerType type;
  final int localId;
  final int unreadCount;
  final int messagesCount;
  final List<Message> messages;
  final List<int> activeIds;
  final String title;
  final int inRead;
  final int outRead;

  factory Conversation.fromVkConversation(VkConversationItem item) =>
      Conversation(
        id: item?.conversation?.peer?.id,
        type: item?.conversation?.peer?.type == null
            ? null
            : vkPeerTypeValues.map[item?.conversation?.peer?.type],
        localId: item?.conversation?.peer?.localId,
        activeIds: item?.conversation?.chatSettings?.activeIds == null
            ? null
            : List<int>.from(
                item.conversation.chatSettings.activeIds.map((x) => x)),
        title: item?.conversation?.chatSettings?.title,
        unreadCount: item?.conversation?.unreadCount,
        messages: item?.lastMessage == null
            ? []
            : [Message.fromVkMessage(item?.lastMessage)],
        inRead: item?.conversation?.inRead,
        outRead: item?.conversation?.outRead,
      );
}
