import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/local_models/message.dart' as MessageModel;
import 'package:vk_messenger_flutter/screens/forwarded_messages_screen.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';
import 'package:vk_messenger_flutter/screens/show_geo_screen.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';
import 'package:vk_messenger_flutter/widgets/attachment.dart';
import 'package:vk_messenger_flutter/widgets/message_skeleton.dart';

class Message extends StatelessWidget {
  void _fwdMsgTapHandler(List<MessageModel.Message> fwdMessages) {
    AppRouter.sailor.navigate(ForwardedMessagesScreen.routeUrl, params: {
      "fwdMessages": fwdMessages,
    });
  }

  void _geoTapHandler(double longitude, double latitude, String place) {
    AppRouter.sailor.navigate(ShowGeoScreen.routeUrl, params: {
      'longitude': longitude,
      'latitude': latitude,
      'place': place,
    });
  }

  void _selectMessageHandler(BuildContext context) {
    final message = Provider.of<MessageModel.Message>(context, listen: false);

    if (message?.isSent == false) {
      return;
    }
    BlocProvider.of<ConversationBloc>(context)
        .add(ConversationSelectMessage(message?.id));
  }

  bool _checkOutRead(BuildContext context, int id) {
    bool read = true;

    final peerId = BlocProvider.of<ConversationBloc>(context)?.state?.peerId;

    final conversation =
        BlocProvider.of<ConversationsBloc>(context)?.state?.getById(peerId);

    final items = conversation?.messages ?? [];

    final outRead = conversation?.outRead;

    if (outRead == id) {
      return true;
    }

    for (int i = 0; i < items.length; i++) {
      if (items[i].id == id) {
        read = false;
        break;
      }
      if (items[i].id == outRead) {
        break;
      }
    }

    return read;
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<MessageModel.Message>(context, listen: false);

    if (item == null) {
      return MessageSkeleton();
    }

    double width = MediaQuery.of(context).size.width * 0.8; // 80% of screen

    final me = item?.isOut == true;

    final text = item?.text ?? '';

    final attachments = item?.attachments ?? [];

    final fwdMessages = item?.fwdMessages ?? [];

    final longitude = item?.longitude;
    final latitude = item?.latitude;
    final place = item?.place;

    var rows = <Widget>[];

    final textAlign = me ? TextAlign.right : TextAlign.left;

    final axisAlign = me ? MainAxisAlignment.end : MainAxisAlignment.start;

    final captionTheme = Theme.of(context).textTheme.caption;

    if (text != '') {
      rows.add(Text(text, textAlign: textAlign));
    }

    if (attachments.length != 0) {
      rows.addAll(
        attachments.map(
          (attachment) => Padding(
            padding: const EdgeInsets.all(5.0),
            child: Provider.value(
              value: attachment,
              child: Attachment(),
            ),
          ),
        ),
      );
    }

    if (fwdMessages.length != 0) {
      rows.add(
        GestureDetector(
          onTap: () => _fwdMsgTapHandler(fwdMessages),
          child: Text(
            'Пересланные сообщения',
            textAlign: textAlign,
            style: captionTheme,
          ),
        ),
      );
    }

    if (longitude != null && latitude != null && place != null) {
      rows.add(
        GestureDetector(
          onTap: () => _geoTapHandler(
            longitude,
            latitude,
            place,
          ),
          child: Text(
            'Местоположение: ${place ?? ''}',
            textAlign: textAlign,
            style: captionTheme,
          ),
        ),
      );
    }

    if (item?.isError == true) {
      rows.add(
        IntrinsicWidth(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.report,
                color: Colors.redAccent,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
              ),
              Text('Не отправлено'),
            ],
          ),
        ),
      );
    }

    if (me) {
      rows.add(
        Icon(
          item.isSent ? Icons.done_all : Icons.done,
          size: 12,
          color: item.isSent && _checkOutRead(context, item?.id)
              ? Colors.blue
              : Colors.black54,
        ),
      );
    }

    final bubbleBody = Container(
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      child: Column(
        children: rows,
        crossAxisAlignment: CrossAxisAlignment.end,
      ),
    );

    return BlocBuilder<ConversationBloc, ConversationState>(
      builder: (_, state) {
        final selectedMessagesIds = state.selectedMessagesIds ?? [];

        final selected =
            selectedMessagesIds.indexWhere((element) => element == item?.id) !=
                -1;

        final showCheckbox = selectedMessagesIds.length > 0;

        return InkWell(
          onTap: showCheckbox ? () => _selectMessageHandler(context) : noop,
          onLongPress: () => _selectMessageHandler(context),
          child: Row(
            mainAxisAlignment: axisAlign,
            children: <Widget>[
              if (showCheckbox && selected) Icon(Icons.check_box),
              if (showCheckbox && !selected)
                Icon(Icons.check_box_outline_blank),
              Bubble(
                margin: BubbleEdges.symmetric(vertical: 7),
                alignment: me ? Alignment.topRight : Alignment.topLeft,
                nip: me ? BubbleNip.rightTop : BubbleNip.leftTop,
                color: me ? Color.fromRGBO(225, 255, 199, 1.0) : null,
                child: item?.isSent == true || item?.isError == true
                    ? bubbleBody
                    : SkeletonAnimation(
                        child: Opacity(
                          opacity: .3,
                          child: bubbleBody,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
