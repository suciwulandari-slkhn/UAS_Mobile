import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uas/Api_obat/conn_obat.dart';
import 'package:uas/Api_obat/model_obat.dart';
import 'package:uas/allObat_list.dart';
import 'package:uas/apotek/apotek.dart';
import 'package:uas/articlePage.dart';
import 'package:uas/coba3.dart';
import 'package:uas/obat/gridObat_berdsPenyakit.dart';
import 'package:uas/profile.dart';
import 'package:uas/widget/big_text.dart';
import 'package:uas/widget/color.dart';
import 'package:uas/widget/dimensions.dart';
import 'package:uas/widget/small_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Obat>> futureObat;
  int _selectedIndex = 0; // Indeks tab yang aktif

  @override
  void initState() {
    super.initState();
    futureObat = Repository.fetchObat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // header
          Container(
            child: Material(
              elevation: 1.5,
              child: ClipRRect(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(
                            text: "Hai Suci!",
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          SmallText(
                            size: Dimensions.font16,
                            text: "Semoga kamu dalam keadaan Baik",
                            color: Colors.black54,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //body
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArticlePageBody(), // artikel
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: BigText(
                        text: 'Kategori Obat per Penyakit',
                      ),
                    ),
                    Pilih3Kategori(),
                    Container(
                      padding: const EdgeInsets.all(3),
                      margin: EdgeInsets.only(left: Dimensions.width20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BigText(
                            text: "Apotek",
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: BigText(
                              text: ".",
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: SmallText(
                              text: "Populer",
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    ApotekList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          color: AppColors.mainColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: GNav(
              color: Colors.white,
              activeColor: AppColors.mainColor,
              tabBackgroundColor: const Color.fromARGB(255, 243, 241, 241),
              gap: 5,
              selectedIndex:
                  _selectedIndex, //mengambil index page yang baru (dibuka skrg)
              onTabChange: (index) {
                handleTabChange(index);
              },
              padding: EdgeInsets.all(10),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.local_hospital_rounded,
                  text: 'Obat',
                ),
                GButton(
                  icon: Icons.sick_rounded,
                  text: 'Penyakit',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi navigasi
  void handleTabChange(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObatListAll(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KategoriObatAll(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => profile(),
          ),
        );
        break;
      default:
    }
  }
}
