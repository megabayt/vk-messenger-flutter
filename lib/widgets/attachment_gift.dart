import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';

class AttachmentGift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final attachment = Provider.of<Attachment>(context, listen: false);

    if (attachment?.gift?.thumb48 == null) {
      return Container();
    }
    return Image(image: NetworkImage(attachment.gift.thumb96));
  }
}
