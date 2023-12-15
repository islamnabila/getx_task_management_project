import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_task_management_project/Screen/pin_verification_screen.dart';
import '../Style/style.dart';
import '../controller/email_verification_controller.dart';
import 'login_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final EmailVerificationController controller = Get.put(EmailVerificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackGround(context),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                  boldTextStyle("Your Email Address"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  GreyTextStyle(
                      "A 6 digit verification pin will send your emai address"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    onChanged:controller.onEmailChanged,
                    decoration: TextFormFieldWhite("Email"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevatedButton(
                      style: ElevattedButtonStyle(),
                      onPressed: () async {
                        bool res = await controller.recoverVerifyEmail();
                        if (res) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PinVerificationScreen(),
                            ),
                          );
                        }
                      },
                      child:
                      ButtonChildStyle(Icons.arrow_circle_right_outlined)),
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
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: TextButtonChildStyle("Sign In"))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
