import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';

class AttachmentSticker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final attachment = Provider.of<Attachment>(context, listen: false);

    final preview = attachment?.preview;
    if (preview == null) {
      return Container();
    }

    return Image(image: NetworkImage(preview));
  }
}
