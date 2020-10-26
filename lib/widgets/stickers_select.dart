import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';

import 'package:vk_messenger_flutter/blocs/stickers/stickers_bloc.dart';
import 'package:vk_messenger_flutter/models/sticker.dart';

class StickersSelect extends StatefulWidget {
  @override
  _StickersSelectState createState() => _StickersSelectState();
}

class _StickersSelectState extends State<StickersSelect> {
  int currentIndex = 0;

  void _retryHandler(BuildContext context) {
    // ignore: close_sinks
    final stickersBloc = BlocProvider.of<StickersBloc>(context);

    stickersBloc.add(StickersFetch());
  }

  void _handleTapProduct(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _handleTapSticker(BuildContext context, Sticker sticker) {
    BlocProvider.of<ConversationBloc>(context).add(
      ConversationSendSticker(sticker: sticker)
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StickersBloc, StickersState>(listener: (_, state) {
      if (state.error != '') {
        final snackBar = SnackBar(
          content: Text(state.error),
          action: SnackBarAction(
            label: 'Повторить',
            onPressed: () => _retryHandler(context),
          ),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      }
    }, builder: (_, state) {
      final products = state.items ?? [];

      final product =
          currentIndex < products.length ? products[currentIndex] : null;

      final stickers = product?.stickers ?? [];

      return Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              crossAxisCount: 6,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              children: stickers.map((sticker) {
                return GestureDetector(
                  onTap: () => _handleTapSticker(context, sticker),
                  child: Image.network(sticker?.images[0]?.url),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (BuildContext _, int index) {
                return GestureDetector(
                  onTap: () => _handleTapProduct(index),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.network(products[index]?.previews[0]?.url),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
