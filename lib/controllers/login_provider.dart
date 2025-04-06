import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/zoom_provider.dart';
import 'package:job_app/services/helpers/auth_helper.dart';
import 'package:job_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  // show/hide password
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState){
    _obscureText = newState;
    notifyListeners();
  }

  // entrypoint
  bool _entrypoint = true;

  bool get entrypoint => _entrypoint;

  set entrypoint(bool newState){
    _entrypoint = newState;
    notifyListeners();
  }

  // loggedIn
  bool _loggedIn = true;

  bool get loggedIn => _loggedIn;

  set loggedIn(bool newState){
    _loggedIn = newState;
    notifyListeners();
  }

  // load page
  bool _loader = false;

  bool get loader => _loader;

  set loader(bool newState){
    _loader = newState;
    notifyListeners();
  }

  login(String model, ZoomNotifier zoomNotifier){
    AuthHelper.login(model).then((response){
      if(response == true){
        loader == false;
        zoomNotifier.currentIndex = 0;
        Get.to(()=> const Mainscreen());

      } else{
        loader == false;
        Get.snackbar(
            "Failed to Login",
            "Please check your credentials",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.add_alert)
        );
      }
    });
  }

  getPref() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
    username = prefs.getString('username') ?? '';
    userUid = prefs.getString('uid') ?? '';
    profile = prefs.getString('profile') ?? '';
  }
}
