import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas/allObat_list.dart';
import 'package:uas/apotek/apotek.dart';
import 'package:uas/coba3.dart';
import 'package:uas/home.dart';
import 'package:uas/list_obatperpenyakit.dart';
import 'package:uas/obat/gridObat_berdsPenyakit.dart';
import 'package:uas/profile.dart';
import 'package:uas/service/login.dart';

late FirebaseApp app;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBhzew5sse2e-GYgyVv1Gnfz5MjHVnZpQA",
          appId: "1:842141436301:android:ae284b0134df416c26d5c4",
          messagingSenderId: "842141436301",
          projectId: "uasmobilesuci"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
