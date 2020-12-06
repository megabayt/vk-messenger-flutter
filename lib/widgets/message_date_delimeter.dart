import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/local_models/message.dart';

class MessageDateDelimeter extends StatelessWidget {
  final Message nextItem;

  MessageDateDelimeter(this.nextItem);

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

    final nextDate = _getDateFromTimestamp(nextItem?.date);
    final date = _getDateFromTimestamp(item?.date);

    if (nextDate == null ||
        date == null ||
        date.difference(nextDate).inDays == 0) {
      return Container();
    }

    final diff = today.difference(date).inDays;

    var text;

    if (diff == 0) {
      text = 'Сегодня';
    } else if (diff == 1) {
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
