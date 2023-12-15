import 'package:get/get.dart';

import '../Rest Api/network_response_class.dart';
import '../Rest Api/rest_api.dart';
import '../Utility/url.dart';
import '../model/task_list_model.dart';

class CompletedController extends GetxController{
  bool _getCompletedTaskInProgress = false;
  bool get getCompletedTaskInProgress => _getCompletedTaskInProgress;
  TaskListModel _taskListModel =TaskListModel();
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getCompletedTaskList()async{
    bool isSuccess = false;
    _getCompletedTaskInProgress = true;
   update();
    final NetworkResponse response = await NetworkCaller().getRequest((Urls.getCompletedTask));
    _getCompletedTaskInProgress = false;
    update();
    if(response.isSuccess){
      _taskListModel =TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;

    }
  }
