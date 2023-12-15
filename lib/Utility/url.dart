

import '../widget/newtask_card_item.dart';

class Urls{
  static const String _baseurl="https://task.teamrabbil.com/api/v1";
  static const String registration ="$_baseurl/registration";
  static const String login = "$_baseurl/login";
  static const String createNewTask ="$_baseurl/createTask";
  static String getNewTask = "$_baseurl/listTaskByStatus/${TaskStatus.New.name}";
  static String getProgressTask = "$_baseurl/listTaskByStatus/${TaskStatus.Progress.name}";
  static String getCompletedTask = "$_baseurl/listTaskByStatus/${TaskStatus.Completed.name}";
  static String getCancelledTask = "$_baseurl/listTaskByStatus/${TaskStatus.Cancelled.name}";

  static const String getTaskStatusCount = "$_baseurl/taskStatusCount";
  static String updateTaskStatus(String taskId, String status) => "$_baseurl/updateTaskStatus/$taskId/$status";

  static const String updateProfile = "$_baseurl/profileUpdate";
  static String deleteTask(String taskId) => "$_baseurl/deleteTask/$taskId";
  static String recoverVerifyEmail(String Email) => "$_baseurl/RecoverVerifyEmail/$Email";
  static String recoverVerifyOTP(String Email, String OTP) => "$_baseurl/RecoverVerifyOTP/$Email/$OTP";
  static const String recoverResetPass ="$_baseurl/RecoverResetPass";
}