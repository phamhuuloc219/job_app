import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/services/helpers/auth_helper.dart';
import 'package:job_app/views/screens/auth/login_screen.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState){
    _obscureText = newState;
    notifyListeners();
  }

  bool _loader = false;

  bool get loader => _loader;

  set loader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  final signupFormKey = GlobalKey<FormState>();

  bool validateAndSave(){
    final form = signupFormKey.currentState;

    if(form!.validate()){
      form.save();
      return true;
    } else{
      return false;
    }
  }

  // signUp(String model){
  //   AuthHelper.signup(model).then((response) {
  //     if(response == true){
  //       loader == false;
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         SnackBar(
  //           content: const Text('Sign up successfully'),
  //           backgroundColor: Color(kDark.value),
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //       Get.offAll(()=> const LoginScreen());
  //
  //     } else{
  //       loader == false;
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(
  //         SnackBar(
  //           content: const Text('Failed to Sign up'),
  //           backgroundColor: Color(kDark.value),
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //       Get.offAll(()=> const LoginScreen());
  //     }
  //   });
  // }

  signUp(String model){
    AuthHelper.signup(model).then((response) {
      if(response == true){
        loader == false;
        Get.snackbar(
            "Sign up successfully",
            "Login and apply now",
            colorText: Color(kLight.value),
            backgroundColor: Color(kGreen.value),
            icon: const Icon(Icons.add_alert)
        );
        Get.offAll(()=> const LoginScreen());

      } else{
        loader == false;
        Get.snackbar(
            "Failed to Sign up",
            "Please check your credentials",
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.add_alert)
        );
      }
    });
  }
}
