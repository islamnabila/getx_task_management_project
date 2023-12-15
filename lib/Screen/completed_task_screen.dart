import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_management_project/controller/completed_controller.dart';
import '../Style/style.dart';
import '../widget/newtask_card_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  void onTaskStatusChange() {
    Get.find<CompletedController>().getCompletedTaskList();
  }




  @override
  void initState() {
    super.initState();
    Get.find<CompletedController>().getCompletedTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
              Expanded(
                  child: GetBuilder<CompletedController>(
                    builder: (compleetedController) {
                      return Visibility(
                        visible:compleetedController.getCompletedTaskInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: RefreshIndicator(
                          onRefresh: () async{
                            compleetedController.getCompletedTaskList();
                          },
                          child: ListView.builder(
                              itemCount: compleetedController.taskListModel.taskList?.length ?? 0,
                              itemBuilder: (context, index) {
                                return NewtaskCardItem(
                                    task: compleetedController.taskListModel.taskList![index],
                                    onStatusChange: () {
                                  compleetedController.getCompletedTaskList();
                                },
                                    onTaskStatusChange: onTaskStatusChange,
                                    showProgress: (inProgress){

                                    }
                                );
                              }),
                        ),
                      );
                    }
                  )),
            ],
          ))
    );
  }
}
