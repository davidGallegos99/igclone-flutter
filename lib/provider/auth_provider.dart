import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  String base_url = "10.0.2.2:5000";
  String? token;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  String email = '';
  String password = '';
  final storage = const FlutterSecureStorage();

  Future login(String email, String password) async {
    try {
      final url = Uri.http(base_url, '/iam/auth/login');
      final body = jsonEncode({'email': email, 'password': password});
      final res = await http.post(url,
          body: body,
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      final data = jsonDecode(res.body);
      if (res.statusCode != 200) return data['message'] ?? data['error'];
      token = data['data']['token'] as String;
      await storage.write(key: 'token', value: token);
      await storage.write(key: 'user', value: data['data']['_id']);
      return true;
    } catch (e) {
      return null;
    }
  }

  Future logout() async {
    await storage.deleteAll();
  }

  Future getToken() async {
    final tkn = await storage.read(key: 'token');
    return tkn;
  }

  validForm() {
    return form.currentState?.validate() ?? false;
  }

  static bool emailValidator({String value = ''}) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static bool passwordValidator({String password = ''}) {
    String pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }
}
