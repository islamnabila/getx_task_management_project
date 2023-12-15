import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_management_project/Screen/set_password_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../Style/style.dart';
import '../Utility/utility.dart';
import '../controller/pin_verification_controller.dart';
import 'login_screen.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  final PinVerificationController controller = Get.put(PinVerificationController());

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
                    boldTextStyle("Pin Verification"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    GreyTextStyle(
                        "A 6 digit verification pin will send your email address"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                   PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            activeColor: colorGreen,
                            selectedFillColor: colorWhite,
                            inactiveFillColor: colorWhite,
                            inactiveColor: colorGreen),
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: controller.onOTPChanged,
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    ElevatedButton(
                        style: ElevattedButtonStyle(),
                        onPressed: () async {
                          String? emailVerification = await ReadUserData('EmailVerification');

                          if (emailVerification != null) {
                            bool res = await controller.verifyOTPRequest(
                              emailVerification,
                              controller.otp.value,
                            );

                            if (res) {
                              Get.to(() => const SetPasswordScreen());
                            }
                          } else {
                            print("EmailVerification is null");
                          }
                        },

                        child: ButtonChildStyleText("Verify")),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoldSmallTextStyle("Have account?"),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                            },
                            child: TextButtonChildStyle("Sign In"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
