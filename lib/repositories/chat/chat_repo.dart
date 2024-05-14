
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:raspisanie/repositories/chat/models/chat.dart';

final dio = Dio();
Future<void> saveGroup(String group) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('group', group);
}

Future<void> saveId(String id) async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', id);
}

String? getUserIdFromCookie(String cookie) {
  String cookieString = "cookie1=value1; cookie2=user_id=12345; cookie3=value3"; // Пример строки с куками
  String? userId;

  List<String> cookies = cookieString.split('; '); // Разбить строку куки на отдельные куки

  for (String cookie in cookies) {
    List<String> cookieParts = cookie.split('='); // Разбить каждую куку на ключ и значение
    if (cookieParts.length == 2) {
      if (cookieParts[0] == "user_id") {
        userId = cookieParts[1];
        break;
      }
    }
  }
  return userId;
}

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
      final group = response.headers.value('group_id') ?? "";
      saveGroup(group);
      String? userId;
      List<String>? setCookieHeader = response.headers['set-cookie'];
      print(setCookieHeader);
      if (setCookieHeader != null) {
        for (String cookie in setCookieHeader) {
          List<String> cookieParts = cookie.trim().split(';');

          for (String part in cookieParts) {
            List<String> keyValue = part.trim().split('=');
            if (keyValue[0].trim() == 'user_id') {
              userId = keyValue[1];
            }
          }
        }
      }
      saveId(userId ?? "");
      return data;
    }else{
      throw Exception("123");
    }
  }
  Future<chat> CreateChat(String name) async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await dio.post("http://localhost:8080/api/createroom",data: {'name': name},options: Options(headers: {
      'Accept':'application/json',
      "Authorization":'Bearer $token'
    }));
    if (response.statusCode == 200){
      final Map<String, dynamic> data = response.data;
      final chats = chat.fromJson(data);
      return chats;
    }else{
      throw Exception("smth wrong");
    }
  }
}