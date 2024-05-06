import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raspisanie/repositories/chat/models/chat.dart';

final dio = Dio();

class ChatRepo{
  Future<List<chat>> GetChats() async{
    final response = await dio.get("http://localhost:8080/api/rooms", options: Options(headers: {'Accept':'application/json'}));
    if response.statusCode == 200{
      final data = (jsonDecode(response.data) as List).map((e) => chat.fromJson(e)).toList();
      return data
    }
  }
}