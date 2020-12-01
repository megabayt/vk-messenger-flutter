import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ConversationTileSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SkeletonAnimation(
          child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                  color: Colors.grey[300], shape: BoxShape.circle))),
      title: SkeletonAnimation(
          child: Container(
        height: 14,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
      )),
      subtitle: SkeletonAnimation(
        child: Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
