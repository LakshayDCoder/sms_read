// ignore_for_file: file_names

import 'package:permission_handler/permission_handler.dart';

Future queryPermissions() async {
  List<Permission> permissions = [Permission.contacts, Permission.sms];

  Map<Permission, PermissionStatus> perms = await permissions.request();

  while (true) {
    List<PermissionStatus> status = perms.entries.map((e) => e.value).toList();

    bool allGranted =
        status.every((PermissionStatus perm) => perm.isGranted == true);

    if (allGranted) {
      break;
    }

    perms = await permissions.request();
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
