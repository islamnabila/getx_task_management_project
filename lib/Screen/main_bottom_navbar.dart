import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_task_management_project/Screen/progress_task_screen.dart';
import 'cancelled_task_screen.dart';
import 'completed_task_screen.dart';
import 'new_task_screen.dart';

class MainBottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}

class MainBottomNavScreen extends StatelessWidget {
  final MainBottomNavController controller = Get.put(MainBottomNavController());

  final List<Widget> _screen = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screen[controller.selectedIndex.value]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) {
          controller.changeTabIndex(index);
        },
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: "New"),
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle), label: "In Progress"),
          BottomNavigationBarItem(
              icon: Icon(Icons.beenhere_rounded), label: "Completed"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel), label: "Cancelled"),
        ],
      ),
    );
  }
}
