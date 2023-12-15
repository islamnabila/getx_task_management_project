import 'package:get/get.dart';

import '../Rest Api/network_response_class.dart';
import '../Rest Api/rest_api.dart';
import '../Utility/url.dart';
import '../model/task_list_model.dart';

class ProgressController extends GetxController {
  bool _getProgressTaskInProgress = false;
  bool get getProgressTaskInProgress => _getProgressTaskInProgress;
  TaskListModel _taskListModel = TaskListModel();
  TaskListModel get taskListModel => _taskListModel;


  Future<bool> getProgressTaskList() async {
    bool isSuccess = false;
    _getProgressTaskInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getProgressTask);
    _getProgressTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
