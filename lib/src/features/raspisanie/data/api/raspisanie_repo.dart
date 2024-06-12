
import 'package:dio/dio.dart';
import 'package:raspisanie/src/features/raspisanie/data/models/raspisanie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobx/mobx.dart';

part 'raspisanie_repo.g.dart';




class RaspisanieRe = _RaspisanieRe with _$RaspisanieRe;
final dio = Dio();
abstract class _RaspisanieRe with Store{
  @observable
  RaspisanieM? raspisanieM;

  @action
  Future<RaspisanieM> raspisanie(int week, int day) async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    final response = await dio.post("http://localhost:8080/api/", data: {'week': week - 1, 'day': day}, options: Options(headers: {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    }));
    print(response.data);
    if(response.statusCode == 200) {
      RaspisanieM raspisanieM = RaspisanieM.fromJson(response.data);
      return raspisanieM;
    } else {
      throw Exception('Failed to load data');
    }
  }
}


// class RaspisanieRepo{
//   Future<RaspisanieM> raspisanie(int week, int day) async{
//     final prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('jwt_token');
//     final response = await dio.post("http://localhost:8080/api/", data: {'week': week - 1, 'day': day}, options: Options(headers: {
//       'Accept': 'application/json',
//       "Authorization": "Bearer $token"
//     }));
//     print(response.data);
//     if(response.statusCode == 200) {
//       RaspisanieM raspisanieM = RaspisanieM.fromJson(response.data);
//       return raspisanieM;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }

