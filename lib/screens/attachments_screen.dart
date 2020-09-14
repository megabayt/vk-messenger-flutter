import 'package:flutter/material.dart';
import 'package:vk_messenger_flutter/widgets/attachments_list.dart';

class AttachmentsScreen extends StatelessWidget {
  static const routeUrl = '/attachments';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вложения'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: AttachmentsList(),
    );
  }
}
