import 'package:get/get.dart';
import '../Rest Api/network_response_class.dart';
import '../Rest Api/rest_api.dart';
import '../Utility/url.dart';

class SignUpController extends GetxController {
  final RxBool signupInProgress = false.obs;
  String _failedMessage="";
  String get failedMessage => _failedMessage;

  Future<void> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    signupInProgress.value = true;

    try {
      NetworkResponse response =
      await NetworkCaller()
          .postRequest(Urls.registration, body: {
        "email":email,
        "firstName":firstName,
        "lastName":lastName,
        "mobile":mobile,
        "password":password,
      });

      if (response.statusCode == 200) {
        _failedMessage = "Account has been Created! Please login";
      } else {
        _failedMessage= "Account creation failed! Please try again";
      }
    } catch (error) {
      print('SignUp Exception: $error');
    } finally {
      signupInProgress.value = false;
    }
  }
}

