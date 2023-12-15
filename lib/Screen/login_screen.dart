
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_management_project/Screen/signup_screen.dart';
import '../Rest Api/network_response_class.dart';
import '../Rest Api/rest_api.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../controller/auth_controller.dart';
import '../model/user_model.dart';
import 'email_verification_screen.dart';
import 'main_bottom_navbar.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final RxBool _loginProgress = false.obs;
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
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                      boldTextStyle("Get Started With"),
                      SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                      TextFormField(
                          controller: _emailController,
                          decoration: TextFormFieldWhite("Email"),
                          validator: (String? value){
                            if(value?.trim().isEmpty ?? true){
                              return "Enter your email";
                            }
                            String emailPattern =
                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';

                            RegExp regExp = RegExp(emailPattern);
                            if (!regExp.hasMatch(value!)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          }
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      TextFormField(
                          controller: _passwordController,
                          obscuringCharacter: '*',
                          obscureText: true,
                          decoration: TextFormFieldWhite("Password"),
                          validator: (String? value){
                            if(value?.isEmpty ?? true){
                              return "Enter your password";
                            }
                            if(value!. length <6){
                              return "Password must have more than 6 digits";
                            }
                            return null;
                          }
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                      Visibility(
                        visible: !_loginProgress.value ,
                        replacement:const Center(child: CircularProgressIndicator(),),
                        child: ElevatedButton(
                            style: ElevattedButtonStyle(),
                            onPressed: login,
                            child: ButtonChildStyle(Icons.arrow_circle_right_outlined) ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                      Center(child: TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (contex)=>const EmailVerificationScreen(),));
                      }, child: TextButtonChildStyleGrey("Forget Password?"))),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoldSmallTextStyle("Don't have account?"),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpScreen(),));
                          }, child:TextButtonChildStyle("Sign up"))
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
  Future<void> login()async{
    if(!_globalKey.currentState!.validate()){
      return;
    }
    _loginProgress.value = true;

    NetworkResponse response = await NetworkCaller().postRequest(Urls.login, body: {
      "email": _emailController.text.trim(),
      "password" : _passwordController.text,
    }, isLogin: true,);
    _loginProgress.value = false;

    if(response.isSuccess) {
      await Get.find<AuthController>().saveUserInformation(
          response.jsonResponse["token"], UserModel.fromJson(response.jsonResponse["data"]));
      clearTextField();
      Get.off(() => MainBottomNavScreen());
    }else{
      if(response.statusCode ==401){
          showSnackMessage(context, "Please check email/password");
      }else{
          showSnackMessage(context, "Login failed! Try again");
      }
    }
  }

  void clearTextField(){
    _emailController.clear();
    _passwordController.clear();
  }

}
