import 'package:get_it/get_it.dart';
import 'package:sms_read/core/chat_room_controller.dart';
import 'package:sms_read/core/sms_controller.dart';
import 'package:sms_read/core/contact_controller.dart';
import 'package:sms_read/core/permission_controller.dart';
import 'package:sms_read/repo/check_number_repo.dart';
import 'package:sms_read/repo/contacts_repo.dart';
import 'package:sms_read/repo/sms_repo.dart';

import '../core/check_number_controller.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<SMSRepo>(() => SMSRepo());
  locator.registerLazySingleton<SMSController>(() => SMSController());
  locator.registerLazySingleton<ContactRepo>(() => ContactRepo());
  locator.registerSingleton<ContactController>(ContactController());
  locator.registerLazySingleton<PermissionController>(
      () => PermissionController());
  locator.registerLazySingleton<ChatRoomController>(() => ChatRoomController());
  locator.registerLazySingleton<CheckNumberRepo>(() => CheckNumberRepo());
  locator.registerLazySingleton<CheckNumberController>(
      () => CheckNumberController());
}
