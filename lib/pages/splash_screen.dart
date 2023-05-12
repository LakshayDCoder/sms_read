import 'package:flutter/material.dart';
import 'package:sms_read/utils/locator.dart';

import '../core/permission_controller.dart';
import 'chat_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool permissionsGranted = false;

  @override
  void initState() {
    super.initState();

    locator.get<PermissionController>().getPermissions(context).then((_) {
      setState(() {
        permissionsGranted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All SMS(s)"),
        elevation: 0.7,
      ),
      body: permissionsGranted
          ? const ChatScreen()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
