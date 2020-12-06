part of 'stickers_bloc.dart';

@immutable
@CopyWith()
class StickersState {
  final List<StickerPack> items;
  final bool isFetching;
  final String error;

  StickersState({
    this.items = const [],
    this.isFetching = false,
    this.error = '',
  });
}
