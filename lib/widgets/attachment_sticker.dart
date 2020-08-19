import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';

class AttachmentSticker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final attachment = Provider.of<Attachment>(context, listen: false);

    final images = attachment?.sticker?.images ?? [];
    if (images.length <= 1) {
      return Container();
    }

    return Image(image: NetworkImage(images[1].url));
  }
}
