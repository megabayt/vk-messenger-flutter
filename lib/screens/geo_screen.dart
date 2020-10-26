import 'package:flutter/material.dart';

import 'package:vk_messenger_flutter/widgets/geo_map.dart';

class GeoScreen extends StatelessWidget {
  static const routeUrl = '/geo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор местоположения'),
      ),
      body: GeoMap(),
    );
  }
}
