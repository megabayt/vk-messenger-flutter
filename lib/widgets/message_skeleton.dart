import 'dart:math';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class MessageSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8; // 80% of screen
    final me = Random.secure().nextDouble() >= 0.5;

    return Bubble(
      margin: BubbleEdges.symmetric(vertical: 7),
      alignment: me ? Alignment.topRight : Alignment.topLeft,
      nip: me ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: me ? Color.fromRGBO(225, 255, 199, 1.0) : null,
      child: SkeletonAnimation(
        shimmerColor: me ? Colors.grey[200] : Colors.grey[100],
        child: Container(
          width: width,
          height: 50,
        ),
      ),
    );
  }
}
