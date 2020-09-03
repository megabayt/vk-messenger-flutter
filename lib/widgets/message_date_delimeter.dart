import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/message.dart';

class MessageDateDelimeter extends StatelessWidget {
  final Message prevItem;

  MessageDateDelimeter(this.prevItem);

  DateTime _getDateFromTimestamp(int timestamp) {
    if (timestamp == null) {
      return null;
    }

    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final dateWithoutTime = DateTime(date.year, date.month, date.day);

    return dateWithoutTime;
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Message>(context, listen: false);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final prevDate = _getDateFromTimestamp(prevItem?.date);
    final date = _getDateFromTimestamp(item?.date);

    if (prevDate == null ||
        date == null ||
        today.difference(prevDate).inDays == today.difference(date).inDays) {
      return Container();
    }

    final diff = today.difference(date).inDays;

    var text;

    if (diff == 1) {
      text = 'Сегодня';
    } else if (diff == 2) {
      text = 'Вчера';
    } else {
      text =
          '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    }

    return Bubble(
      margin: BubbleEdges.symmetric(vertical: 10),
      alignment: Alignment.center,
      color: Color.fromRGBO(212, 234, 244, 1.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11.0),
      ),
    );
  }
}
