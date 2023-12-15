import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_management_project/controller/newtask_controller.dart';
import '../Style/style.dart';
import '../model/task_count.dart';
import '../widget/newtask_card_item.dart';
import '../widget/newtask_reuseablecard.dart';
import 'add_newtask_screen.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});



  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

//immediately add task without refreshing
typedef TaskCreatedCallback = void Function();

class _NewTaskScreenState extends State<NewTaskScreen> {

  //method for changing number immediately when task updated from one category to another
  void onTaskStatusChange() {
  Get.find<newtaskSummaryListController>().getTaskCountSummaryList();
  }

  @override
  void initState() {
    super.initState();
    Get.find<NewTaskController>().getNewTaskList();
    Get.find<newtaskSummaryListController>().getTaskCountSummaryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorGreen,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNewTaskScreen(
                  onTaskCreated: () {
                    Get.find<NewTaskController>().getNewTaskList();
                  },

                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ListTyleStyle(),
              GetBuilder<newtaskSummaryListController>(
                builder: (controller) {
                  return Visibility(
                    visible: controller.getTaskCountSummaryListInProgress== false && (controller.taskCountSummaryModel.taskCountList?.isNotEmpty ?? false),
                    replacement: const LinearProgressIndicator(),
                    child: SizedBox(
                      height: 120,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.taskCountSummaryModel.taskCountList?.length ?? 0,
                          itemBuilder: (context, index) {
                            TaskCount taskCount = controller.taskCountSummaryModel.taskCountList![index];

                            return FittedBox(
                                child: ReuseableCard(
                                    count: taskCount.sum.toString(),
                                    title: taskCount.sId ?? ""));
                          }),
                    ),
                  );
                }
              ),
              Expanded(
                  child: GetBuilder<NewTaskController>(
                    builder: (newTaskController) {
                      return Visibility(
                        visible:newTaskController.getNewTaskInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: RefreshIndicator(
                          onRefresh: () async{
                            newTaskController.getNewTaskList();
                          },
                          child: ListView.builder(
                              itemCount: newTaskController.taskListModel.taskList?.length ?? 0,
                              itemBuilder: (context, index) {
                                return NewtaskCardItem(
                                    task: newTaskController.taskListModel.taskList![index],
                                    onStatusChange: () {
                                      newTaskController.getNewTaskList();
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
          ),
        ));
  }
}
