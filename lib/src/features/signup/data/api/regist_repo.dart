import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:raspisanie/src/features/signup/data/models/regist.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

class RegistRepo{
  Future<regist> signUp(String email, String password, String name, String group) async{
    final response = await dio.post("http://localhost:8080/auth/signup", data: {'email': email, 'password': password, 'name': name, 'group': group}, options: Options(headers: {
      'Accept': 'application/json',
    }));
    if(response.statusCode == 200) {
      regist registt = regist.fromJson(response.data);
      return registt;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
