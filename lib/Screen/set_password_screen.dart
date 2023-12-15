import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Rest Api/rest_api.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../controller/set_password_controller.dart';
import 'login_screen.dart';

class SetPasswordScreen extends StatelessWidget {
   SetPasswordScreen({super.key});
  final SetPasswordController controller = Get.put(SetPasswordController());

  Future<bool> setPasswordRequest() async {
    try {
      controller.loading.value = true;

      final response = await NetworkCaller().postRequest(
        Urls.recoverResetPass,
        body: controller.formValues,
      );

      if (response.statusCode == 200 && response.jsonResponse['status'] == "success") {
        showSnackMessage(Get.context!, "Request Success");
        return true;
      } else {
        showSnackMessage(Get.context!, "Request failed!");
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      controller.loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackGround(context),
          Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),
                    boldTextStyle("Set Password"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    GreyTextStyle("Minimum length password 8 characters with a letter and number combination"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      onChanged: (textValue) {
                        controller.inputOnChange("password", textValue);
                      },
                      decoration: TextFormFieldWhite("Password"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      onChanged: (textValue) {
                        controller.inputOnChange("cpassword", textValue);
                      },
                      obscureText: true,
                      decoration: TextFormFieldWhite("Confirm Password"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ElevatedButton(
                      style: ElevattedButtonStyle(),
                      onPressed: () async {
                        bool res = await setPasswordRequest();
                        if (res) {
                          Get.offAll(() => const LoginScreen());
                        }
                      },
                      child: Obx(() => ButtonChildStyleText(controller.loading.value ? "Loading..." : "Confirm")),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoldSmallTextStyle("Have an account?"),
                        TextButton(
                          onPressed: () {
                            Get.off(() => const LoginScreen());
                          },
                          child: TextButtonChildStyle("Sign In"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
