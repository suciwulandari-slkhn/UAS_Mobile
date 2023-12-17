import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uas/allObat_list.dart';
import 'package:uas/home.dart';
import 'package:uas/obat/gridObat_berdsPenyakit.dart';
import 'package:uas/widget/color.dart';

class profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<profile> {
  int _selectedIndex = 3; // Indeks tab yang aktif skrg

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text('Profil'),
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Tambahkan untuk memusatkan vertikal
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(
                    'assets/image/suci.jpg',
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Suci Wulandari',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'suciwulandari.slhkn@gmail.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
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
                handleTabChange(index, context);
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
  void handleTabChange(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });

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
        // Navigasi ke halaman pencarian (ObatList)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObatListAll(),
          ),
        );
        break;
      case 2:
        // Navigasi ke halaman kategori obat
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => KategoriObatAll(),
          ),
        );
        break;
      case 3:
        // Navigasi ke halaman profile
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
