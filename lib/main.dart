import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getx_task_management_project/controller/addnewtask_controller.dart';
import 'package:getx_task_management_project/controller/cancell_controller.dart';
import 'package:getx_task_management_project/controller/completed_controller.dart';
import 'package:getx_task_management_project/controller/newtask_controller.dart';
import 'package:getx_task_management_project/controller/progress_controller.dart';
import 'Screen/splash_screen.dart';
import 'Style/style.dart';
import 'controller/auth_controller.dart';
void main(){
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigationKey,
      theme: ThemeData(
        primaryColor: colorGreen,
      ),
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
class ControllerBinder extends Bindings{
  @override
  void dependencies() {

    Get.put(AuthController());
    Get.put(NewTaskController());
    Get.put(newtaskSummaryListController());
    Get.put(AddNewTaskController());
    Get.put(ProgressController());
    Get.put(CompletedController());
    Get.put(CancelledController());
  }
}
