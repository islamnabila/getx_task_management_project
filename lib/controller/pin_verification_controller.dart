import 'package:get/get.dart';
import '../Rest Api/rest_api.dart';
import '../Utility/url.dart';
import '../Utility/utility.dart';


class PinVerificationController extends GetxController {
  RxBool loading = false.obs;
  RxString otp = ''.obs;

  Future<bool> verifyOTPRequest(String email, String otp) async {
    loading.value = true;

    final response = await NetworkCaller().getRequest(Urls.recoverVerifyOTP(email, otp));

    if (response.statusCode == 200 && response.jsonResponse['status'] == "success") {
      await WriteOTPVerification(otp);
      if (loading.value) {
        Get.snackbar("Success", "Pin verified successfully!");
      }
    } else {
      if (loading.value) {
        Get.snackbar("Error", "Pin is not correct");
      }
    }

    loading.value = false;
    return response.statusCode == 200 && response.jsonResponse['status'] == "success";
  }

  void onOTPChanged(String textValue) {
    otp.value = textValue;
  }
}
