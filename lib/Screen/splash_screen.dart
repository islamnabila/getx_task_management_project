import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Style/style.dart';
import '../controller/auth_controller.dart';
import 'login_screen.dart';
import 'main_bottom_navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loginScreen();
  }

  Future<void> loginScreen() async {
    final bool isLogedin = await Get.find<AuthController>().checkAuthState();

    Timer(const Duration(seconds: 2), () {
      Get.offAll(isLogedin
          ? MainBottomNavScreen()
          : const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackGround(context),
          Center(child: ScreenLogo(context))
        ],
      ),
    );
  }
}


