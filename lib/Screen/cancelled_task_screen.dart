import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_management_project/controller/cancell_controller.dart';
import '../Style/style.dart';
import '../widget/newtask_card_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  void onTaskStatusChange() {
    Get.find<CancelledController>().getCancelledTaskList();
  }
  @override
  void initState() {
    super.initState();
    Get.find<CancelledController>().getCancelledTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
              Expanded(
                child: GetBuilder<CancelledController>(
                  builder: (canclledController) {
                    return Visibility(
                      visible: canclledController.getCancelledTaskInprogress == false,
                      replacement:const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: RefreshIndicator(
                        onRefresh: canclledController.getCancelledTaskList,
                        child: ListView.builder(
                            itemCount: canclledController.taskListModel.taskList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return NewtaskCardItem(
                                  task: canclledController.taskListModel.taskList![index],
                                  onStatusChange: () {
                                canclledController.getCancelledTaskList();
                              },
                                  onTaskStatusChange: onTaskStatusChange,
                                  showProgress: (inProgress){

                                  }
                              );
                            }),
                      ),
                    );
                  }
                ),
              ),
            ],
          ))
    );
  }
}
