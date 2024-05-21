import 'package:raspisanie/src/features/profile/data/models/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class ProfileRepo{
  Future<User> getUser() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await dio.get("http://localhost:8080/api/getuser", options: Options(headers: {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    }));
    print(token);
    if (response.statusCode == 200){
      User user = User.fromJson(response.data);
      print(user);
      return user;
    }else{
      throw Exception("incorrect smth");
    }
  }
  Future<void> updateUser(String email, String name, String password, String group) async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await dio.put("http://localhost:8080/api/updateuser", data: {'email': email, 'name': name, 'password': password, 'group': group} ,options: Options(headers: {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    }));
    if (response.statusCode == 200){
      return;
    }else{
      throw Exception("smth wrong");
    }
  }
}