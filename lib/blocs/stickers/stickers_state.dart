part of 'stickers_bloc.dart';

@immutable
class StickersState {
  final List<StickerPack> items;
  final bool isFetching;
  final String error;

  StickersState({
    this.items = const [],
    this.isFetching = false,
    this.error = '',
  });

  StickersState copyWith({
    List<StickerPack> items,
    bool isFetching,
    String error,
  }) =>
      StickersState(
        items: items ?? this.items,
        isFetching: isFetching ?? this.isFetching,
        error: error ?? this.error,
      );
}
