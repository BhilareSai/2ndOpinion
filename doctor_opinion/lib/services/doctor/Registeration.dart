import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:developer';

class DoctorRegisterationApi {
  static Future<bool> validateUsername(String username) async {
    // var response = await http.post(
    //   Uri.parse("https://devignite.vercel.app/api/quiz"),
    //   body: username,
    // );
    await Future.delayed(Duration(milliseconds: 1000));
    if (username.length > 3) {
      return true;
    }

    return false;
  }

  static Future<bool> validateEmail(String email) async {
    // var response = await http.post(
    //   Uri.parse("https://devignite.vercel.app/api/quiz"),
    //   body: username,
    // );
    await Future.delayed(Duration(milliseconds: 1000));
    if (email == "bhilaresai64@gmail.com") {
      return true;
    }
    return false;
  }

  static Future<bool> validatePhone(String phone) async {
    // var response = await http.post(
    //   Uri.parse("https://devignite.vercel.app/api/quiz"),
    //   body: username,
    // );
    await Future.delayed(Duration(milliseconds: 1000));
    if (phone == "0123456789") {
      return true;
    }
    return false;
  }
}
