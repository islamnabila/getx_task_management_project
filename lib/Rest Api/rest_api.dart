import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Screen/login_screen.dart';
import '../controller/auth_controller.dart';
import '../main.dart';
import 'network_response_class.dart';

class NetworkCaller {
  //for handling post request
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      log(url);
      log(body.toString());
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: <String, String>{
           "Content-type": "Application/json",
          'token' : AuthController.token.toString(),

          });

      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      } else if(response.statusCode==401){
        if(isLogin ==false){
          backTologin();
        }
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
      else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }





//for handling get request
  Future<NetworkResponse> getRequest(String url) async {
    try {
      log(url);
      final Response response =
      await get(Uri.parse(url),
          headers: <String, String>{
            "Content-type": "Application/json",
            'token' : AuthController.token.toString(),

          });

      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      } else if(response.statusCode==401){
          backTologin();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
      else {
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }


  Future<void> backTologin() async {
    await AuthController.clearAuthData();
    Navigator.pushAndRemoveUntil(
        MyApp.navigationKey.currentContext!, MaterialPageRoute(builder: (context)=>const LoginScreen()), (route) => false);
  }
}
