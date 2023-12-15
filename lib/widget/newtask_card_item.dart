import 'package:flutter/material.dart';
import '../Rest Api/rest_api.dart';
import '../Style/style.dart';
import '../Utility/url.dart';
import '../model/task_list.dart';

enum TaskStatus { New, Progress, Completed, Cancelled }

class NewtaskCardItem extends StatefulWidget {
  const NewtaskCardItem({
    super.key,
    required this.task, required this.onStatusChange, required this.showProgress, required this.onTaskStatusChange,
  });

  final Task task;
  final VoidCallback onStatusChange;
  final VoidCallback onTaskStatusChange;
  final Function(bool) showProgress;

  @override
  State<NewtaskCardItem> createState() => _NewtaskCardItemState();
}

class _NewtaskCardItemState extends State<NewtaskCardItem> {
  Future<void> updateTaskStatus(String status)async {
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.updateTaskStatus(widget.task.sId ?? "", status));
    if(response.isSuccess){
      widget.onStatusChange();
      widget.onTaskStatusChange();
    }
    widget.showProgress(false);
  }

  Future<void> deleteTask() async{
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.deleteTask(widget.task.sId ?? ""));
    if(response.isSuccess){
      widget.onStatusChange();
      widget.onTaskStatusChange();
    }
    widget.showProgress(false);
  }

  @override
  Widget build(BuildContext context) {
    Color chipBackgroundColor = getChipBackgroundColor(widget.task.status);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? "",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5,),
            Text(widget.task.description ?? "", style: const TextStyle(fontSize: 15.5),),
            const SizedBox(height: 5,),
            Text("Date: ${widget.task.createdDate ?? ""}",style: const TextStyle(fontSize: 15.5),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? "New",
                    style: const TextStyle(color: colorWhite),
                  ),
                  backgroundColor: chipBackgroundColor,
                ),
                Wrap(
                  children: [
                    IconButton(onPressed: () {
                      showDeleteStatusModal();
                    }, icon: const Icon(Icons.delete, color: Colors.red,)),
                    IconButton(
                        onPressed: () {
                          showUpdateStatusModal();
                        },
                        icon: const Icon(Icons.edit, color: colorGreen,))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {
    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: () {
                updateTaskStatus(e.name);
                Navigator.pop(context);
              },
            ))
        .toList();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Status"),
            content: Column(mainAxisSize: MainAxisSize.min, children: items),
            actions: [
              ButtonBar(
                children: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text("Cancel")),

                ],
              )
            ],
          );
        });
  }

  void showDeleteStatusModal() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Status"),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text("Cancel")),
              TextButton(onPressed: (){
                deleteTask();
                Navigator.pop(context);
              }, child: const Text("Delete"))

            ],
          );
        });
  }

  Color getChipBackgroundColor(String? status) {
    switch (status) {
      case 'New':
        return Colors.orange;
      case 'Progress':
        return Colors.deepPurple;
      case 'Completed':
        return Colors.blue.shade600;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
