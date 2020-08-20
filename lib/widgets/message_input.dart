import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyText1.color;
    final hintColor = Theme.of(context).textTheme.caption.color;
    return Row(
      children: <Widget>[
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 1.0),
          child: IconButton(
            icon: Icon(Icons.insert_emoticon),
            onPressed: () {},
            color: primaryColor,
          ),
        ),
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 1.0),
          child: IconButton(
            icon: Icon(Icons.attach_file),
            onPressed: () {},
            color: primaryColor,
          ),
        ),
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
              focusNode: focusNode,
            ),
          ),
        ),

        // Button send message
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
