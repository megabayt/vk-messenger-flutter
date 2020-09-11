import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/models/message.dart' as MessageModel;
import 'package:vk_messenger_flutter/screens/forwarded_messages_screen.dart';
import 'package:vk_messenger_flutter/screens/router.dart';
import 'package:vk_messenger_flutter/utils/helpers.dart';
import 'package:vk_messenger_flutter/widgets/attachment.dart';
import 'package:vk_messenger_flutter/widgets/message_skeleton.dart';

class Message extends StatelessWidget {
  void _fwdMsgTapHandler(List<MessageModel.Message> fwdMessages) {
    Router.sailor.navigate(ForwardedMessagesScreen.routeUrl, params: {
      "fwdMessages": fwdMessages,
    });
  }

  void _selectMessageHandler(BuildContext context) {
    final message = Provider.of<MessageModel.Message>(context, listen: false);
    // ignore: close_sinks
    final conversationBloc = BlocProvider.of<ConversationBloc>(context);

    if (message?.isSent == false) {
      return;
    }
    conversationBloc.add(ConversationSelectMessage(message?.id));
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<MessageModel.Message>(context, listen: false);

    if (item == null) {
      return MessageSkeleton();
    }

    double width = MediaQuery.of(context).size.width * 0.8; // 80% of screen

    final me = item?.out == 1;

    final text = item?.text ?? '';

    final attachments = item?.attachments ?? [];

    final fwdMessages = item?.fwdMessages ?? [];

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
