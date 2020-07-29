import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vk_messenger_flutter/store/vk_store.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<VkStore>(context, listen: false).login(),
      builder: (BuildContext builderContext, AsyncSnapshot dataSnapshot) {
        return Scaffold(
          body: Consumer<VkStore>(
            builder: (consumerContext, vkStoreData, _) {
              final isAuthenticated = vkStoreData.isAuthenticated;
              if (!isAuthenticated) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: Text(vkStoreData.token),
              );
            },
          ),
        );
      },
    );
  }
}
