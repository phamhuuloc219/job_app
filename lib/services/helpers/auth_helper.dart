import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_app/models/request/auth/login_model.dart';
import 'package:job_app/models/request/auth/profile_update_model.dart';
import 'package:job_app/models/request/auth/signup_model.dart';
import 'package:job_app/models/response/auth/login_res_model.dart';
import 'package:job_app/models/response/auth/profile_model.dart';
import 'package:job_app/models/response/auth/profile_res_model.dart';
import 'package:job_app/models/response/auth/skills.dart';
import 'package:job_app/services/config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> signup(String model) async{
    try{
      Map<String, String> requestHeaders = {
        'Content-Type' : 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.signupUrl);

      var response = await client.post(url, headers: requestHeaders, body: model);
      if(response.statusCode == 201){
        return true;
      } else{
        return false;
      }
    } catch(e){
        return false;
    }
  }

  static Future<bool> login(String model) async{
      Map<String, String> requestHeaders = {
        'Content-Type' : 'application/json',
      };

      var url = Uri.https(Config.apiUrl, Config.loginUrl);

      var response = await client.post(url, headers: requestHeaders, body: model);
      if(response.statusCode == 200){
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        var user = loginResponseModelFromJson(response.body);

        await prefs.setString('token', user.userToken);
        await prefs.setString('userId', user.id);
        await prefs.setString('uid', user.uid);
        await prefs.setString('profile', user.profile);
        await prefs.setString('username', user.username);
        await prefs.setBool('loggedIn', true);

        return true;
      } else{
        return false;
      }
  }

  static Future<ProfileRes> getProfile() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    if(token == null){
      throw Exception("No authentication token provided");
    }

    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json',
      'authorization' : 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);

    try{
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200){
        var profile = profileResFromJson(response.body);
        return profile;
      } else{
        throw Exception("Failed to get profile");
      }
    } catch (e) {
      throw Exception("Failed to get profile: ${e.toString()}");
    }
  }

  static Future<List<Skills>> getSkills() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    if(token == null){
      throw Exception("No authentication token provided");
    }

    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json',
      'authorization' : 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.skillsUrl);

    try{
      var response = await client.get(url, headers: requestHeaders);

      if (response.statusCode == 200){
        var skills = skillsFromJson(response.body);
        return skills;
      } else{
        throw Exception("Failed to get skills");
      }
    } catch (e) {
      throw Exception("Failed to get skills: ${e.toString()}");
    }
  }

  static Future<bool> deleteSkill(String id) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    if(token == null){
      throw Exception("No authentication token provided");
    }

    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json',
      'authorization' : 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, '${Config.skillsUrl}/$id');

    try{
      var response = await client.delete(url, headers: requestHeaders);

      if (response.statusCode == 200){
        return true;
      } else{
        return false;
      }
    } catch (e) {
      throw Exception("Failed to delete skills: ${e.toString()}");
    }
  }

  static Future<bool> addSkill(String model) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    if(token == null){
      throw Exception("No authentication token provided");
    }

    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json',
      'authorization' : 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.skillsUrl);

    try{
      var response = await client.post(url, headers: requestHeaders, body: model);

      if (response.statusCode == 200){
        return true;
      } else{
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updatePassword(String model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      throw Exception("No authentication token provided");
    }

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };

    var url = Uri.https(Config.apiUrl, Config.changePasswordUrl);

    try {
      var response = await client.put(url, headers: requestHeaders, body: model);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<UpdateProfileRes> fetchProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception("No authentication token provided");
    }

    final headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };

    final url = Uri.https(Config.apiUrl, Config.profileUrl);
    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      return updateProfileResFromJson(response.body);
    } else {
      throw Exception("Failed to fetch profile (status ${response.statusCode})");
    }
  }

  static Future<UpdateProfileRes> updateProfile(ProfileUpdateReq reqModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception("No authentication token provided");
    }

    final headers = {
      'Content-Type': 'application/json',
      'authorization': 'Bearer $token',
    };

    final url = Uri.https(Config.apiUrl, Config.updateProfileUrl);
    final body = jsonEncode(reqModel.toJson());

    final response = await client.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return updateProfileResFromJson(response.body);
    } else {
      throw Exception("Failed to update profile (status ${response.statusCode})");
    }
  }

}
