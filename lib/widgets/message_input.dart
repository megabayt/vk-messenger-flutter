import 'package:badges/badges.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_messenger_flutter/blocs/attachments/attachments_bloc.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/screens/attachments_screen.dart';
import 'package:vk_messenger_flutter/screens/app_router.dart';
import 'package:vk_messenger_flutter/widgets/stickers_select.dart';

class MessageInput extends StatefulWidget {
  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController textEditingController = TextEditingController();

  void _pickEmojiHandler(Emoji emoji, Category _) {
    textEditingController.text += emoji.emoji;
  }

  void _tapAttachHandler() {
    AppRouter.sailor.navigate(AttachmentsScreen.routeUrl);
  }

  Future<void> _sendHandler(context) async {
    BlocProvider.of<ConversationBloc>(context).add(
      ConversationSendMessage(
        message: textEditingController.text,
      ),
    );
    textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttachmentsBloc, AttachmentsState>(
      builder: (_, attachmentsState) {
        return BlocBuilder<ConversationBloc, ConversationState>(
          builder: (_, conversationState) {
            final showEmojiKeyboard = conversationState?.showEmojiKeyboard;

            final primaryColor = Theme.of(context).primaryColor;
            final textColor = Theme.of(context).textTheme.bodyText1.color;
            final hintColor = Theme.of(context).textTheme.caption.color;

            var attachCount = 0;

            final fwdMessages = attachmentsState?.fwdMessages ?? [];
            if (fwdMessages.length != 0) {
              attachCount += 1;
            }

            final attachments = attachmentsState?.attachments ?? [];
            if (attachments.length != 0) {
              attachCount += attachments.length;
            }

            final location = attachmentsState?.location;
            if (location.latitude != 0 && location.longitude != 0) {
              attachCount += 1;
            }

            final replyTo = attachmentsState?.replyTo;
            if (replyTo != 0) {
              attachCount += 1;
            }

            final attachBtn = IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: _tapAttachHandler,
              color: primaryColor.withOpacity(.5),
            );

            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, .1),
                    blurRadius: 10,
                    offset: Offset.zero,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.insert_emoticon),
                        onPressed: () =>
                            BlocProvider.of<ConversationBloc>(context)
                                .add(ConversationToggleEmojiKeyboard()),
                        color: showEmojiKeyboard
                            ? primaryColor
                            : primaryColor.withOpacity(.5),
                      ),
                      attachCount != 0
                          ? Badge(
                              badgeContent: Text(
                                attachCount.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              child: attachBtn,
                            )
                          : attachBtn,
                      // Edit text
                      Flexible(
                        child: Container(
                          child: TextField(
                            style: TextStyle(color: textColor, fontSize: 15.0),
                            controller: textEditingController,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Сообщение',
                              hintStyle: TextStyle(color: hintColor),
                            ),
                          ),
                        ),
                      ),

                      // Button send message
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => _sendHandler(context),
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  if (showEmojiKeyboard)
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            labelColor: Theme.of(context).primaryColor,
                            unselectedLabelColor:
                                Theme.of(context).primaryColor,
                            tabs: [
                              Tab(text: 'Смайлы'),
                              Tab(text: 'Стикеры'),
                            ],
                          ),
                          Container(
                            height: 291.5,
                            child: TabBarView(
                              children: [
                                EmojiPicker(
                                  rows: 4,
                                  columns: 7,
                                  numRecommended: 10,
                                  onEmojiSelected: _pickEmojiHandler,
                                ),
                                StickersSelect(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
