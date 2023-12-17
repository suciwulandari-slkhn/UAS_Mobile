import 'package:dio/dio.dart';
import 'package:uas/Api_apotek/model_apt.dart';
class RepositoryApt {
  static Future<List<Apotek>> fetchApotek() async {
    try {
      Response response =
          await Dio().get("https://656740e864fcff8d73100a51.mockapi.io/apt");

      List<Apotek> apotekList =
          (response.data as List).map((json) => Apotek.fromJson(json)).toList();

      return apotekList;
    } catch (error) {
      print("Error fetching apotek data: $error");
      throw error;
    }
  }
}
