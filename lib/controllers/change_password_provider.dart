import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/request/auth/change_password_model.dart';
import 'package:job_app/services/helpers/auth_helper.dart';
import 'package:job_app/views/screens/auth/login_screen.dart';

class ChangePasswordNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _loader = false;
  bool get loader => _loader;
  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  final changePasswordFormKey = GlobalKey<FormState>();

  String oldPassword = '';
  String newPassword = '';

  bool validateAndSave() {
    final form = changePasswordFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> changePassword() async {
    if (!validateAndSave()) return;

    loader = true;

    try {
      final changePassModel = ChangePasswordModel(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      final jsonBody = changePasswordModelToJson(changePassModel);

      final success = await AuthHelper.updatePassword(jsonBody);

      loader = false;

      if (success) {
        Get.snackbar(
          'Success',
          'Password changed successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Failed',
          'Failed to change password. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      loader = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
