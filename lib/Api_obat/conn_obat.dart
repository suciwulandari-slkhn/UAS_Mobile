import 'package:dio/dio.dart';
import 'package:uas/Api_obat/model_obat.dart';

class Repository {
  static Future<List<Obat>> fetchObat() async {
    try {
      Response response =
          await Dio().get("https://656421c2ceac41c0761d79cd.mockapi.io/user");

      List<Obat> obatList =
          (response.data as List).map((v) => Obat.fromJson(v)).toList();

      return obatList;
    } catch (error) {
      print("Error fetching obat data: $error");
      throw error; 
    }
  }
}
