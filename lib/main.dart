import 'package:flutter/material.dart';
import 'package:sms_read/utils/locator.dart';

import 'pages/splash_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const SmsApp());
}

class SmsApp extends StatelessWidget {
  const SmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterSMSApp",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
