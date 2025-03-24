import 'package:flutter/material.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  set obscureText(bool newState){
    _obscureText = newState;
    notifyListeners();
  }
}
