import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Style/style.dart';
import '../controller/addnewtask_controller.dart';
import 'new_task_screen.dart';

class AddNewTaskScreen extends GetView<AddNewTaskController> {
   AddNewTaskScreen({Key? key, required this.onTaskCreated}) : super(key: key);
  final TaskCreatedCallback onTaskCreated;
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ListTyleStyle(),
            Expanded(
              child: Stack(
                children: [
                  ScreenBackGround(context),
                  SingleChildScrollView(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                              boldTextStyle("Add New Task"),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                              TextFormField(
                                controller: _subjectController,
                                decoration: TextFormFieldWhite("Subject"),
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return "Enter subject";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              TextFormField(
                                controller: _desController,
                                maxLines: 6,
                                decoration: TextFormFieldWhite("Description"),
                                validator: (String? value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return "Enter Description";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                              Obx(
                                    () => Visibility(
                                  visible: controller.createTaskInProgress ==false,
                                  replacement: const Center(child: CircularProgressIndicator()),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorGreen,
                                    ),
                                    onPressed: () {
                                      createTask();
                                    },
                                    child: ButtonChildStyle(Icons.arrow_circle_right_outlined),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
   Future<void> createTask() async {
     if (_formKey.currentState!.validate()) {
       bool isSuccess = await controller.createTask(
         title: _subjectController.text.trim(),
         description: _desController.text.trim(),
       );

       _subjectController.clear();
       _desController.clear();

       if (isSuccess) {
         Get.snackbar(
           'Success',
           'Task created successfully!',
           snackPosition: SnackPosition.BOTTOM
         );
       } else {
         Get.snackbar(
           'Error',
           'Failed to create task. Please try again.',
           snackPosition: SnackPosition.BOTTOM
           ,
         );
       }
       onTaskCreated.call();
     }
   }
}
