import 'package:get/get.dart';
import '../Rest Api/network_response_class.dart';
import '../Rest Api/rest_api.dart';
import '../Utility/url.dart';
import 'newtask_controller.dart';

class AddNewTaskController extends GetxController {
  var createTaskInProgress = false.obs;

  Future<bool> createTask({
    required String title,
    required String description,
  }) async {
    createTaskInProgress.value = true;
    update();

    final NetworkResponse response = await NetworkCaller().postRequest(
      Urls.createNewTask,
      body: {
        "title": title,
        "description": description,
        "status": "New",
      },
    );

    createTaskInProgress.value = false;
    update();

    if (response.isSuccess) {
      Get.find<NewTaskController>().getNewTaskList();
      Get.find<newtaskSummaryListController>().getTaskCountSummaryList();
      return true;

    } else {
    }
    return false;
  }
}


