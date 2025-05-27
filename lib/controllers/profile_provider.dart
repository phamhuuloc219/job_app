import 'package:flutter/material.dart';
import 'package:job_app/models/request/auth/profile_update_model.dart';
import 'package:job_app/models/response/auth/profile_res_model.dart';
import 'package:job_app/services/helpers/auth_helper.dart';

class ProfileNotifier extends ChangeNotifier {
  UpdateProfileRes? _profile;
  bool _isLoading = false;
  String? _error;

  UpdateProfileRes? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final p = await AuthHelper.fetchProfile();
      _profile = p;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    required String username,
    required String location,
    required String phone,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final req = ProfileUpdateReq(
        username: username,
        location: location,
        phone: phone,
      );

      final updated = await AuthHelper.updateProfile(req);

      _profile = updated;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
