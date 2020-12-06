import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info/device_info.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';
import 'package:vk_messenger_flutter/vk_models/register_device_params.dart';
import 'package:vk_messenger_flutter/vk_models/unregister_device_params.dart';

part 'firebase_event.dart';
part 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  FirebaseBloc() : super(FirebaseInitial());
  final VKService _vkService = locator<VKService>();
  FirebaseMessaging _firebaseMessaging;

  @override
  Stream<FirebaseState> mapEventToState(
    FirebaseEvent event,
  ) async* {
    if (event is FirebaseInit) {
      yield* _mapFirebaseInitToState();
    }
    if (event is FirebasePushSub) {
      yield* _mapFirebasePushSubToState();
    }
    if (event is FirebasePushUnsub) {
      yield* _mapFirebasePushUnsubToState();
    }
  }

  Stream<FirebaseState> _mapFirebaseInitToState() async* {
    try {
      await Firebase.initializeApp();
      yield FirebaseInitiated();
    } catch (_) {
      yield FirebaseInitFailed();
    }
  }

  Stream<FirebaseState> _mapFirebasePushSubToState() async* {
    try {
      _firebaseMessaging = FirebaseMessaging.instance;
      await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      final token = await _firebaseMessaging.getToken();

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      final result = await _vkService.registerDevice(RegisterDeviceParams(
        token: token,
        deviceModel: androidInfo.model,
        // deviceYear: androidInfo.device,
        deviceId: androidInfo.androidId,
        systemVersion: androidInfo.version.release,
        settings: {
          'msg': ['on'],
          'chat': ['on']
        },
        // 'sandbox': '0',
      ));

      print(result.response);
    } catch (err) {
      print(err);
    }
  }

  Stream<FirebaseState> _mapFirebasePushUnsubToState() async* {
    await _vkService.unregisterDevice(UnregisterDeviceParams(
      deviceId: 123456789,
    ));
  }
}
