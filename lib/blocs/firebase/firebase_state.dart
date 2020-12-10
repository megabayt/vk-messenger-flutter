part of 'firebase_bloc.dart';

@immutable
abstract class FirebaseState {}

class FirebaseInitial extends FirebaseState {}

class FirebaseInitiated extends FirebaseState {}

class FirebaseInitFailed extends FirebaseState {}
