import 'package:get/get.dart';

class SetPasswordController extends GetxController {
  RxBool loading = false.obs;
  RxMap<String, String> formValues = {
    "email": "",
    "OTP": "",
    "password": "",
    "cpassword": "",
  }.obs;

  void inputOnChange(String mapKey, String textValue) {
    formValues[mapKey] = textValue;
  }
}
