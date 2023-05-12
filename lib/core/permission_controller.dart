// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController {
  Future getPermissions(BuildContext context) async {
    List<Permission> permissions = [Permission.contacts, Permission.sms];
    Map<Permission, PermissionStatus> perms = await permissions.request();
    while (true) {
      List<PermissionStatus> status =
          perms.entries.map((e) => e.value).toList();
      bool allGranted =
          status.every((PermissionStatus perm) => perm.isGranted == true);
      if (allGranted) {
        break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("We need SMS & contact permissions to continue."),
        ),
      );
      perms = await permissions.request();
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }
}
