import 'package:get_it/get_it.dart';

import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/vk_service_impl.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<VKService>(() => VkServiceImpl());
  // locator.registerLazySingleton<PlayerService>(() => PlayerServiceImpl());
  // locator.registerLazySingleton<UploadService>(() => UploadServiceImpl());
}
