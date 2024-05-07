import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raspisanie/repositories/chat/models/chat.dart';

final dio = Dio();

class ChatRepo{
  Future<List<chat>> GetChats() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await dio.get("http://localhost:8080/api/rooms", options: Options(headers: {
      'Accept':'application/json',
      "Authorization":'Bearer $token'
    }));
    if (response.statusCode == 200){
      final List<dynamic> responseData = response.data;
      final List<chat> data = responseData.map((e) => chat.fromJson(e)).toList();
      print(data);
      return data;
    }else{
      throw Exception("123");
    }
  }
}