import 'package:flutter/material.dart';

import 'core/permission_service.dart';
import 'pages/chatScreen.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  ApplicationState createState() => ApplicationState();
}

class ApplicationState extends State<Application> {
  bool permissionsGranted = false;

  @override
  void initState() {
    super.initState();

    queryPermissions().then((_) {
      setState(() {
        permissionsGranted = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FlutterSMSApp"),
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
