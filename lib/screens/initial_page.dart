import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/store/auth_store.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AuthStore>(context, listen: false).login(),
      builder: (BuildContext builderContext, AsyncSnapshot dataSnapshot) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
