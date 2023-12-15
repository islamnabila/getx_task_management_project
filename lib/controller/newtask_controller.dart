import 'package:get/get.dart';

import '../Rest Api/network_response_class.dart';
import '../Rest Api/rest_api.dart';
import '../Utility/url.dart';
import '../model/task_count_summary_model.dart';
import '../model/task_list_model.dart';

class NewTaskController extends GetxController{
  bool _getNewTaskInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  TaskListModel get taskListModel => _taskListModel;
  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _getNewTaskInProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getNewTask);
    _getNewTaskInProgress = false;
    update();
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;

  }
}

class newtaskSummaryListController extends GetxController{

 bool _getTaskCountSummaryListInProgress = false;
 bool get getTaskCountSummaryListInProgress => _getTaskCountSummaryListInProgress;
 TaskCountSummaryModel _taskCountSummaryModel = TaskCountSummaryModel();
 TaskCountSummaryModel get taskCountSummaryModel=> _taskCountSummaryModel;


  Future<bool> getTaskCountSummaryList() async {
    bool isSuccess = false;
    _getTaskCountSummaryListInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.getTaskStatusCount);
    _getTaskCountSummaryListInProgress = false;
    update();
    if (response.isSuccess) {
      _taskCountSummaryModel =
          TaskCountSummaryModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;


  }
}