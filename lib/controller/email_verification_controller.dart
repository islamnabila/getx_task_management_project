import 'package:get/get.dart';
import '../Rest Api/rest_api.dart';
import '../Utility/url.dart';
import '../Utility/utility.dart';

class EmailVerificationController extends GetxController {
  RxBool loading = false.obs;
  RxString email = ''.obs;

  Future<bool> recoverVerifyEmail() async {
    loading.value = true;

    final response = await NetworkCaller().getRequest(Urls.recoverVerifyEmail(email.value));

    if (response.statusCode == 200 && response.jsonResponse['status'] == "success") {
      await WriteEmailVerification(email.value);
      if (loading.value) {
        Get.snackbar("Success", "Check your email");
      }
    } else {
      if (loading.value) {
        Get.snackbar("Error", "Request failed! Try again");
      }
    }
    loading.value = false;
    return response.statusCode == 200 && response.jsonResponse['status'] == "success";
  }

  void onEmailChanged(String textValue) {
    email.value = textValue;
  }
}
