import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uas/Api_obat/conn_obat.dart';
import 'package:uas/Api_obat/model_obat.dart';
import 'package:uas/home.dart';
import 'package:uas/obat/detail_obat.dart';
import 'package:uas/obat/gridObat_berdsPenyakit.dart';
import 'package:uas/profile.dart';
import 'package:uas/widget/color.dart';

class ObatListAll extends StatefulWidget {
  @override
  _ObatListAllState createState() => _ObatListAllState();
}

class _ObatListAllState extends State<ObatListAll> {
  late Future<List<Obat>> obatList;
  List<Obat> filteredObatList = [];

  @override
  void initState() {
    super.initState();
    obatList = Repository
        .fetchObat(); // Mengambil daftar obat dari repository saat widget diinisialisasi
  }

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
            title: Text('List Obat'),
            automaticallyImplyLeading:
                false, // Menghapus tombol kembali pada AppBar
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<Obat>>(
          future: obatList, // Menampilkan daftar obat berdasarkan hasil future
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Menampilkan indikator loading saat mengambil data
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                      'Error: ${snapshot.error}')); // Menampilkan pesan error jika pengambilan data gagal
            } else {
              List<Obat> allObatList =
                  snapshot.data!; // Mendapatkan daftar obat dari snapshot
              allObatList.sort((a, b) => a.name!
                  .compareTo(b.name!)); // Mengurutkan daftar secara alfabetis

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          filteredObatList = allObatList
                              .where((obat) => obat.name!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList(); // Memfilter daftar obat berdasarkan nilai pencarian
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Cari Obat',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredObatList.isNotEmpty
                          ? filteredObatList.length
                          : allObatList.length,
                      itemBuilder: (context, index) {
                        Obat obat = filteredObatList.isNotEmpty
                            ? filteredObatList[index]
                            : allObatList[
                                index]; // Menampilkan baik daftar yang difilter maupun daftar lengkap

                        return Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8),
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(obat.image ?? ""),
                                ),
                              ),
                            ),
                            title: Text(obat.name ?? ""),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CobaDetail(
                                    obat: obat,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
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
              selectedIndex: 1,
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
        Navigator.pushReplacement(
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
