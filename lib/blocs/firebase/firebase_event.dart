part of 'firebase_bloc.dart';

@immutable
abstract class FirebaseEvent {}

class FirebaseInit extends FirebaseEvent {}

class FirebasePushSub extends FirebaseEvent {}

class FirebasePushUnsub extends FirebaseEvent {}
