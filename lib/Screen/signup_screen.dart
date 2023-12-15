import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Style/style.dart';
import '../controller/signup_controller.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fNameController = TextEditingController();
  final TextEditingController _lNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.put(SignUpController());


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
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      boldTextStyle("Join With Us"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: TextFormFieldWhite("Email"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your valid email";
                          }
                          String emailPattern =
                              r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

                          RegExp regExp = RegExp(emailPattern);
                          if (!regExp.hasMatch(value!)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _fNameController,
                        decoration: TextFormFieldWhite("First Name"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your first name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _lNameController,
                        decoration: TextFormFieldWhite("Last Name"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return " Enter your last name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _mobileController,
                        decoration: TextFormFieldWhite("Mobile"),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your mobile number";
                          }
                          if (value!.trim().length != 11) {
                            return "Mobile number must be 11 digits";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      TextFormField(
                        controller: _passController,
                        obscuringCharacter: '*',
                        obscureText: true,
                        decoration: TextFormFieldWhite("Password"),
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return "Enter your password";
                          }
                          if (value!.length < 6) {
                            return "Password must be more than 6 letters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Obx(
                        () => Visibility(
                          visible: !_signUpController.signupInProgress.value,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                              style: ElevattedButtonStyle(),
                              onPressed: _signupOnpressed,

                              child: ButtonChildStyle(
                                  Icons.arrow_circle_right_outlined)),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldSmallTextStyle("Have an account?"),
                          TextButton(
                              onPressed: () {
                                Get.to(const LoginScreen());
                              },
                              child: TextButtonChildStyle("Sign In"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> _signupOnpressed()async {
    if (_formkey.currentState!.validate()) {
      await _signUpController.signUp(
        email: _emailController.text.trim(),
        firstName: _fNameController.text.trim(),
        lastName: _lNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        password: _passController.text,
      );
      if (_signUpController.signupInProgress.value) {
      } else {
        _clearTextField();
        if (_signUpController.failedMessage.isNotEmpty) {
          if (mounted) {
            showSnackMessage(context, _signUpController.failedMessage);
          }
        }
      }
    }
  }
  void _clearTextField(){
    _emailController.clear();
    _fNameController.clear();
    _lNameController.clear();
    _mobileController.clear();
    _passController.clear();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _fNameController.dispose();
    _lNameController.dispose();
    _mobileController.dispose();
    _passController.dispose();
    super.dispose();
  }
}


