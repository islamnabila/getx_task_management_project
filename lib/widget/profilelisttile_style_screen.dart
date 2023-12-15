import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screen/edit-profile_screen.dart';
import '../Screen/login_screen.dart';
import '../Style/style.dart';
import '../controller/auth_controller.dart';

class ProfileListTileStyle extends StatelessWidget {
  const ProfileListTileStyle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Uint8List imageBytes =
    //     Base64Decoder().convert(AuthController.user?.photo?.trim() ?? "");

    String? photoData = Get.find<AuthController>().user?.photo;
    Uint8List? imageBytes;

    try {
      if (photoData != null && photoData.isNotEmpty) {
        imageBytes = const Base64Decoder().convert(photoData.trim());
      }
    } catch (e) {
      print("Error decoding Base64 string: $e");
    }

    return GetBuilder<AuthController>(
      builder: (authController) {
        return ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(),
                ));
          },
          leading: CircleAvatar(
            child: imageBytes != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(30),
                child: Image.memory(imageBytes, fit: BoxFit.cover,))
                : const Icon(Icons.person),
          ),


          title: Text(
            fullname(authController),
            style: const TextStyle(fontSize: 18, color: colorWhite),
          ),
          subtitle: Text(
            Get.find<AuthController>().user?.email ?? "",
            style: const TextStyle(color: colorWhite),
          ),
          tileColor: colorGreen,
          trailing: IconButton(
            onPressed: () async {
              await AuthController.clearAuthData();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false);

            },
            icon: const Icon(Icons.logout, color: colorWhite,),
          ),
        );
      }
    );
  }

  String fullname(AuthController authController) {
    return "${authController.user?.firstName ?? ""} ${authController.user?.lastName ?? ")"}";
  }
}
