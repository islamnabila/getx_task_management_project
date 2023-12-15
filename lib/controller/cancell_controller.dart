import 'package:get/get.dart';
import '../Rest Api/network_response_class.dart';
import '../Rest Api/rest_api.dart';
import '../Utility/url.dart';
import '../model/task_list_model.dart';

class CancelledController extends GetxController {

  bool _getCancelledTaskInprogress = false;
  bool get getCancelledTaskInprogress => _getCancelledTaskInprogress;
  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCancelledTaskList() async {
    bool isSuccess = false;
    _getCancelledTaskInprogress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getCancelledTask);
    _getCancelledTaskInprogress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
