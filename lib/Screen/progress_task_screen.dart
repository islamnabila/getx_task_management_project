import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_management_project/controller/progress_controller.dart';
import '../Style/style.dart';
import '../widget/newtask_card_item.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  void onTaskStatusChange() {
    Get.find<ProgressController>().getProgressTaskList();
  }
 @override
  void initState() {
    super.initState();
    Get.find<ProgressController>().getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
            Expanded(
              child: GetBuilder<ProgressController>(
                builder: (progressController) {
                  return Visibility(
                    visible: progressController.getProgressTaskInProgress == false,
                    replacement:const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: progressController.getProgressTaskList,
                      child: ListView.builder(
                          itemCount: progressController.taskListModel.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return NewtaskCardItem(
                                task: progressController.taskListModel.taskList![index], onStatusChange: () {
                              progressController.getProgressTaskList();
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
          ),
        )
    );
  }
}


