import 'package:flutter/material.dart';

import 'package:vk_messenger_flutter/widgets/select_geo_map.dart';

class SelectGeoScreen extends StatelessWidget {
  static const routeUrl = '/select_geo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выбор местоположения'),
      ),
      body: SelectGeoMap(),
    );
  }
}
